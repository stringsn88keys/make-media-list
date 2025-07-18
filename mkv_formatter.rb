#!/usr/bin/env ruby

require 'pathname'

# Get all MKV files from the specified directory
video_path = "\\\\videos\\media"
output_file = "formatted_mkv_list.txt"

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
  # Get filename without extension
  name_without_ext = File.basename(file, ".*")
  
  # Convert to title case
  title_case = name_without_ext.downcase.split(/[\s_-]+/).map(&:capitalize).join(' ')
  
  # Add to array
  formatted_names << title_case
end

# Sort the names alphabetically
formatted_names.sort!

# Output to text file
File.open(output_file, 'w:UTF-8') do |f|
  formatted_names.each { |name| f.puts name }
end

puts "Formatted #{mkv_files.length} MKV filenames to '#{output_file}'"
puts "Files processed from: #{video_path}"
