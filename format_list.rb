#!/usr/bin/env ruby

require 'pathname'
require 'time'

# Read the current formatted list
input_file = "formatted_mkv_list.txt"
output_file = "formatted_mkv_list_updated.txt"
video_path = case RUBY_PLATFORM
             when /mswin|mingw|cygwin/
               "\\\\videos\\media"
             when /darwin/
              "/Volumes/Media"
             else
              "/videos/media"
             end

# Read existing formatted names
formatted_names = File.readlines(input_file, chomp: true)

# Function to capitalize Roman numerals
def capitalize_roman_numerals(text)
  # Common Roman numerals patterns
  roman_patterns = [
    /\bii\b/i, /\biii\b/i, /\biv\b/i, /\bv\b/i, /\bvi\b/i, 
    /\bvii\b/i, /\bviii\b/i, /\bix\b/i, /\bx\b/i, /\bxi\b/i, /\bxii\b/i
  ]
  
  result = text
  roman_patterns.each do |pattern|
    result = result.gsub(pattern) { |match| match.upcase }
  end
  result
end

# Function to put years in parentheses
def format_years(text)
  # Match 4-digit years (1900-2099)
  text.gsub(/\b(19|20)\d{2}\b/) { |year| "(#{year})" }
end

# Function to get file creation date
def get_creation_date(video_path, formatted_name)
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

# Process each line
updated_names = []
formatted_names.each_with_index do |name, index|
  puts "Processing #{index + 1}/#{formatted_names.length}: #{name}"
  
  # Apply formatting
  updated_name = name
  updated_name = capitalize_roman_numerals(updated_name)
  updated_name = format_years(updated_name)
  
  # Get creation date
  creation_date = get_creation_date(video_path, name)
  
  # Add creation date
  final_name = "#{updated_name} - added #{creation_date}"
  updated_names << final_name
end

# Write to new file
File.open(output_file, 'w:UTF-8') do |f|
  updated_names.each { |name| f.puts name }
end

puts "\nProcessing complete!"
puts "Updated #{updated_names.length} entries"
puts "Output written to: #{output_file}"
