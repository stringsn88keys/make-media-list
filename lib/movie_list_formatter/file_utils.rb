module MovieListFormatter
  module FileUtils
    def self.read_lines(filename, chomp: true)
      File.readlines(filename, chomp: chomp)
    end

    def self.write_lines(filename, lines)
      File.open(filename, 'w:UTF-8') do |f|
        lines.each { |line| f.puts line }
      end
    end

    def self.get_video_path
      # Try to load configuration
      config_path = File.join(__dir__, '..', '..', '.config.rb')
      if File.exist?(config_path)
        require config_path
        Config.video_path
      else
        # Fallback to hardcoded paths if config doesn't exist
        case RUBY_PLATFORM
        when /mswin|mingw|cygwin/
          "\\\\videos\\media"
        when /darwin/
          "/Volumes/Media"
        else
          "/videos/media"
        end
      end
    end
  end
end
