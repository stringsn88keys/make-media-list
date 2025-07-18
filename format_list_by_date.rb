#!/usr/bin/env ruby

# Add lib directory to load path
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'movie_list_formatter'

# Configuration
input_file = "formatted_mkv_list_updated.txt"
output_file = "formatted_mkv_list_by_date.txt"

# Read existing formatted names with dates
formatted_names = MovieListFormatter::FileUtils.read_lines(input_file)

# Group movies by date
movies_by_date = {}

formatted_names.each do |line|
  next if line.strip.empty?
  
  date = MovieListFormatter::DateUtils.extract_date(line)
  movie_name = MovieListFormatter::DateUtils.extract_movie_name(line)
  
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
    formatted_date = MovieListFormatter::DateUtils.format_date_display(date_obj)
    
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

MovieListFormatter::ProgressReporter.report_grouping_stats(formatted_names.length, movies_by_date.keys.length, output_file)
puts "\nDates found (newest first):"
sorted_dates.first(10).each do |date|
  date_obj = Date.parse(date)
  formatted_date = MovieListFormatter::DateUtils.format_date_display(date_obj)
  count = movies_by_date[date].length
  puts "  #{formatted_date}: #{count} movie#{'s' if count != 1}"
end

if sorted_dates.length > 10
  puts "  ... and #{sorted_dates.length - 10} more dates"
end
