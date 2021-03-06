# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "s3streambackup"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jakub Pastuszek"]
  s.date = "2013-08-06"
  s.description = "Stores data from STDIN in S3 object using multipart upload and removes oldest backups to keep maximum desired backup object count."
  s.email = "jpastuszek@gmail.com"
  s.executables = ["s3streambackup", "s3streamrestore"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/s3streambackup",
    "bin/s3streamrestore",
    "features/s3streambackup.feature",
    "features/step_definitions/s3streambackup_steps.rb",
    "features/support/env.rb",
    "lib/s3streambackup.rb",
    "lib/s3streambackup/units.rb",
    "s3streambackup.gemspec",
    "spec/s3streambackup_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/jpastuszek/s3streambackup"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "streaming backup of STDIN to S3 object"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cli>, ["~> 1.3"])
      s.add_runtime_dependency(%q<aws-sdk>, ["~> 1.10"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8"])
      s.add_development_dependency(%q<simplecov-rcov>, [">= 0"])
    else
      s.add_dependency(%q<cli>, ["~> 1.3"])
      s.add_dependency(%q<aws-sdk>, ["~> 1.10"])
      s.add_dependency(%q<rspec>, ["~> 2.8"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8"])
      s.add_dependency(%q<simplecov-rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<cli>, ["~> 1.3"])
    s.add_dependency(%q<aws-sdk>, ["~> 1.10"])
    s.add_dependency(%q<rspec>, ["~> 2.8"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8"])
    s.add_dependency(%q<simplecov-rcov>, [">= 0"])
  end
end

