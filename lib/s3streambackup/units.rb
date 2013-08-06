class Numeric
	UNITS = %w{bytes KiB MiB GiB TiB PiB EiB}
	def in_bytes_auto
		size = self.to_f
		units = UNITS.dup

		while size > 999
			size /= 1024
			units.shift
		end

		if units.length == UNITS.length
			"#{'%d' % size} #{units.first}"
		else
			"#{'%.1f' % size} #{units.first}"
		end
	end
end

