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
