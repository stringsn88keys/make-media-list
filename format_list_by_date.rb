#!/usr/bin/env ruby

require 'pathname'
require 'time'
require 'date'

# Read the current formatted list
input_file = "formatted_mkv_list_updated.txt"
output_file = "formatted_mkv_list_by_date.txt"

# Read existing formatted names with dates
formatted_names = File.readlines(input_file, chomp: true)

# Function to extract date from the "added YYYY-MM-DD" format
def extract_date(line)
  if match = line.match(/- added (\d{4}-\d{2}-\d{2})$/)
    Date.parse(match[1])
  else
    Date.new(1900, 1, 1) # Default to very old date for unknown dates
  end
end

# Function to extract movie name without the date suffix
def extract_movie_name(line)
  line.gsub(/ - added \d{4}-\d{2}-\d{2}$/, '')
end

# Group movies by date
movies_by_date = {}

formatted_names.each do |line|
  next if line.strip.empty?
  
  date = extract_date(line)
  movie_name = extract_movie_name(line)
  
  date_key = date.strftime("%Y-%m-%d")
  movies_by_date[date_key] ||= []
  movies_by_date[date_key] << movie_name
end

# Sort dates in descending order (newest first)
sorted_dates = movies_by_date.keys.sort { |a, b| Date.parse(b) <=> Date.parse(a) }

# Write to new file grouped by date
File.open(output_file, 'w:UTF-8') do |f|
  sorted_dates.each do |date_str|
    date_obj = Date.parse(date_str)
    formatted_date = date_obj.strftime("%B %d, %Y") # e.g., "July 18, 2025"
    
    f.puts "=" * 60
    f.puts "ADDED ON #{formatted_date.upcase}"
    f.puts "=" * 60
    f.puts
    
    # Sort movies within each date alphabetically
    movies_by_date[date_str].sort.each do |movie|
      f.puts movie
    end
    
    f.puts
  end
end

puts "\nProcessing complete!"
puts "Grouped #{formatted_names.length} movies by #{movies_by_date.keys.length} different dates"
puts "Output written to: #{output_file}"
puts "\nDates found (newest first):"
sorted_dates.first(10).each do |date|
  date_obj = Date.parse(date)
  formatted_date = date_obj.strftime("%B %d, %Y")
  count = movies_by_date[date].length
  puts "  #{formatted_date}: #{count} movie#{'s' if count != 1}"
end

if sorted_dates.length > 10
  puts "  ... and #{sorted_dates.length - 10} more dates"
end
