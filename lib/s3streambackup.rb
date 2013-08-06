require 'cli'
require 'aws-sdk'
require 'logger'
require 's3streambackup/units'

## HACK: Auto select region based on location_constraint
module AWS
	class S3
		class BucketCollection
			def [](name)
				# if name is DNS compatible we still cannot use it for writes if it does contain dots
				return S3::Bucket.new(name.to_s, :owner => nil, :config => config) if client.dns_compatible_bucket_name?(name) and not name.include? '.'

				# save region mapping for bucket for futher requests
				@@location_cache = {} unless defined? @@location_cache
				# if we have it cased use it; else try to fetch it and if it is nil bucket is in standard region
				region = @@location_cache[name] || @@location_cache[name] = S3::Bucket.new(name.to_s, :owner => nil, :config => config).location_constraint || @@location_cache[name] = :standard

				# no need to specify region if bucket is in standard region
				return S3::Bucket.new(name.to_s, :owner => nil, :config => config) if region == :standard

				# use same config but with region specified for buckets that are not DNS compatible or have dots and are not in standard region
				S3::Bucket.new(name.to_s, :owner => nil, :config => config.with(region: region))
			end
		end
	end
end

class S3StreamBackup
	def initialize(&block)
		instance_eval &block
		cli_setup = @cli_setup
		cli_verify_setup = @cli_verify_setup
		settings = CLI.new do
				option :key, 
					short: :k,
					description: 'S3 key',
					default: ENV['AWS_ACCESS_KEY_ID']
				option :secret, 
					short: :s,
					description: 'S3 key secret',
					default_label: '<secret>',
					default: ENV['AWS_SECRET_ACCESS_KEY']
				option :prefix,
					short: :p,
					description: 'prefix under which the backup objects are kept',
					default: ''
				option :log_file,
					short: :l,
					description: 'location of log file; if not specifed log to STDERR'
				switch :plain,
					description: 'use plain connections instead of SSL to S3'
				switch :verbose,
					short: :v,
					description: 'log debug messages'
				switch :debug,
					short: :d,
					description: 'log AWS SDK debug messages'
				argument :bucket,
					description: 'name of bucket to upload data to'
				argument :name,
					description: 'name under which the object will be stored'
				instance_eval &cli_setup if cli_setup
		end.parse! do |settings|
			fail 'AWS_ACCESS_KEY_ID environment not set and --key not used' unless settings.key
			fail 'AWS_SECRET_ACCESS_KEY environment not set and --secret not used' unless settings.secret
			instance_eval &cli_verify_setup if cli_verify_setup
		end

		log = Logger.new(settings.log_file ? settings.log_file : STDERR)
		log.formatter = proc do |severity, datetime, progname, msg|
			"[#{datetime.utc.strftime "%Y-%m-%d %H:%M:%S.%6N %Z"}] [#{$$}] #{severity}: #{msg.strip}\n"
		end

		log.level = Logger::INFO
		log.level = Logger::DEBUG if settings.verbose or settings.debug

		begin
			s3 = AWS::S3.new(
				access_key_id: settings.key,
				secret_access_key: settings.secret,
				logger: settings.debug ? log : nil,
				log_level: :debug,
				use_ssl: ! settings.plain
			)
			@main.call(settings, log, s3)
		rescue => error
			msg = "#{error.class.name}: #{error.message}\n#{error.backtrace.join("\n")}"
			log.error msg
			STDERR.write msg 
			exit 10
		end
	end

	def cli(&block)
		@cli_setup = block
	end

	def cli_verify(&block)
		@cli_verify_setup = block
	end

	def main(&block)
		@main = block
	end
end

class ProgeressLogger
	def initialize
		@bytes = 0
	end

	def log(logger, postfix)
		if logger.debug?
			was, @output_bytes = @output_bytes || '', @bytes.in_bytes_auto
			logger.debug "#{@output_bytes}#{postfix}"
		end
	end

	def <<(bytes)
		@bytes += bytes
	end

	def to_s
		@bytes.to_s
	end

	include Comparable
	def <=>(value)
		@bytes <=> value
	end

	def in_bytes_auto
		@bytes.in_bytes_auto
	end
end

