#!/usr/bin/env ruby

# Add lib directory to load path
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'movie_list_formatter'

# Configuration
input_file = "formatted_mkv_list.txt"
output_file = "formatted_mkv_list_updated.txt"
video_path = MovieListFormatter::FileUtils.get_video_path

# Read existing formatted names
formatted_names = MovieListFormatter::FileUtils.read_lines(input_file)

# Process each line
updated_names = []
formatted_names.each_with_index do |name, index|
  MovieListFormatter::ProgressReporter.report_progress(index + 1, formatted_names.length, name)
  
  # Apply formatting
  updated_name = MovieListFormatter::TextFormatter.format_title(name)
  
  # Get creation date
  creation_date = MovieListFormatter::DateUtils.get_creation_date(video_path, name)
  
  # Add creation date
  final_name = "#{updated_name} - added #{creation_date}"
  updated_names << final_name
end

# Write to new file
MovieListFormatter::FileUtils.write_lines(output_file, updated_names)

MovieListFormatter::ProgressReporter.report_completion(updated_names.length, output_file)
