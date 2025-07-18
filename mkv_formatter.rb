#!/usr/bin/env ruby

# Add lib directory to load path
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'movie_list_formatter'

# Load configuration
config_path = File.join(__dir__, '.config.rb')
if File.exist?(config_path)
  require config_path
  output_file = Config.input_file
else
  # Fallback to default name
  output_file = "formatted_mkv_list.txt"
end

video_path = MovieListFormatter::FileUtils.get_video_path

# Check if the directory exists
unless Dir.exist?(video_path)
  puts "Error: Directory #{video_path} does not exist."
  exit 1
end

# Get all .mkv files
mkv_files = Dir.glob(File.join(video_path, "*.mkv"))

if mkv_files.empty?
  puts "Warning: No MKV files found in #{video_path}"
  exit 0
end

# Process each file and convert to title case
formatted_names = []
mkv_files.each do |file|
  # Convert filename to title case using shared utility
  title_case = MovieListFormatter::TextFormatter.filename_to_title_case(file)
  
  # Add to array
  formatted_names << title_case
end

# Sort the names alphabetically
formatted_names.sort!

# Output to text file
MovieListFormatter::FileUtils.write_lines(output_file, formatted_names)

puts "Formatted #{mkv_files.length} MKV filenames to '#{output_file}'"
puts "Files processed from: #{video_path}"
