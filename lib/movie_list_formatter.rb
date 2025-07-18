#!/usr/bin/env ruby

require 'pathname'
require 'time'
require 'date'

# Add the movie_list_formatter subdirectory to the load path
$LOAD_PATH.unshift(File.join(__dir__, 'movie_list_formatter'))

module MovieListFormatter
  # Require all submodules
  require_relative 'movie_list_formatter/file_utils'
  require_relative 'movie_list_formatter/text_formatter'
  require_relative 'movie_list_formatter/date_utils'
  require_relative 'movie_list_formatter/progress_reporter'
end
