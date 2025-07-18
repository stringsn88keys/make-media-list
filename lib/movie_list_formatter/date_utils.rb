require 'date'

module MovieListFormatter
  module DateUtils
    # Function to extract date from the "added YYYY-MM-DD" format
    def self.extract_date(line)
      if match = line.match(/- added (\d{4}-\d{2}-\d{2})$/)
        Date.parse(match[1])
      else
        Date.new(1900, 1, 1) # Default to very old date for unknown dates
      end
    end

    # Function to extract movie name without the date suffix
    def self.extract_movie_name(line)
      line.gsub(/ - added \d{4}-\d{2}-\d{2}$/, '')
    end

    # Function to get file creation date
    def self.get_creation_date(video_path, formatted_name)
      # Try to find the original file by removing formatting and looking for matches
      search_name = formatted_name.downcase
        .gsub(/[^a-z0-9\s]/, '') # Remove special characters
        .gsub(/\s+/, '*') # Replace spaces with wildcards for glob
      
      # Look for files that might match
      pattern = File.join(video_path, "*#{search_name}*.mkv")
      matches = Dir.glob(pattern, File::FNM_CASEFOLD)
      
      if matches.any?
        file_path = matches.first
        begin
          creation_time = File.ctime(file_path)
          return creation_time.strftime("%Y-%m-%d")
        rescue
          return "unknown"
        end
      else
        # Try a simpler search with just the first few words
        first_words = search_name.split('*')[0..2].join('*')
        pattern = File.join(video_path, "*#{first_words}*.mkv")
        matches = Dir.glob(pattern, File::FNM_CASEFOLD)
        
        if matches.any?
          file_path = matches.first
          begin
            creation_time = File.ctime(file_path)
            return creation_time.strftime("%Y-%m-%d")
          rescue
            return "unknown"
          end
        end
      end
      
      "unknown"
    end

    # Format date for display (e.g., "July 18, 2025")
    def self.format_date_display(date)
      date.strftime("%B %d, %Y")
    end
  end
end
