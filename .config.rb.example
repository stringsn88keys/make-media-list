# Configuration for make-media-list project

class Config
  # Video directory paths by platform
  VIDEO_PATHS = {
    # Windows platforms
    windows: "\\\\videos\\media",
    
    # macOS
    darwin: "/Volumes/Media",
    
    # Linux and other Unix-like systems
    unix: "/videos/media",
    
    # Custom path (override with your specific path)
    # custom: "/path/to/your/video/directory"
  }.freeze

  # Default file names
  FILES = {
    input_file: "formatted_mkv_list.txt",
    updated_file: "formatted_mkv_list_updated.txt",
    grouped_file: "formatted_mkv_list_by_date.txt"
  }.freeze

  # Get the appropriate video path for the current platform
  def self.video_path
    case RUBY_PLATFORM
    when /mswin|mingw|cygwin/
      VIDEO_PATHS[:windows]
    when /darwin/
      VIDEO_PATHS[:darwin]
    else
      VIDEO_PATHS[:unix]
    end
  end

  # Get file paths
  def self.input_file
    FILES[:input_file]
  end

  def self.updated_file
    FILES[:updated_file]
  end

  def self.grouped_file
    FILES[:grouped_file]
  end
end
