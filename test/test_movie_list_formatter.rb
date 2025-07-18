#!/usr/bin/env ruby

require 'minitest/autorun'
require 'date'

# Add lib directory to load path
$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))

require 'movie_list_formatter'

class TestMovieListFormatter < Minitest::Test
  
  def setup
    @sample_movie_line = "The Matrix (1999) - added 2024-09-18"
    @sample_filename = "the_matrix_1999.mkv"
  end

  # Test TextFormatter module
  def test_capitalize_roman_numerals
    input = "star trek ii the wrath of khan"
    expected = "star trek II the wrath of khan"
    result = MovieListFormatter::TextFormatter.capitalize_roman_numerals(input)
    assert_equal expected, result
  end

  def test_format_years
    input = "The Matrix 1999"
    expected = "The Matrix (1999)"
    result = MovieListFormatter::TextFormatter.format_years(input)
    assert_equal expected, result
  end

  def test_filename_to_title_case
    input = "the_matrix-1999.mkv"
    expected = "The Matrix 1999"
    result = MovieListFormatter::TextFormatter.filename_to_title_case(input)
    assert_equal expected, result
  end

  def test_format_title_full
    input = "star trek ii 1982 bbc"
    expected = "star trek II (1982) BBC"
    result = MovieListFormatter::TextFormatter.format_title(input)
    assert_equal expected, result
  end

  def test_capitalize_bbc
    input = "Pride And Prejudice Disc 1 Bbc Colin Firth"
    expected = "Pride And Prejudice Disc 1 BBC Colin Firth"
    result = MovieListFormatter::TextFormatter.format_title(input)
    assert_equal expected, result
  end

  # Test Acronyms module
  def test_capitalize_acronyms_bbc
    input = "bbc news"
    expected = "BBC news"
    result = MovieListFormatter::Acronyms.capitalize_acronyms(input)
    assert_equal expected, result
  end

  def test_capitalize_acronyms_mtv
    input = "mtv unplugged"
    expected = "MTV unplugged"
    result = MovieListFormatter::Acronyms.capitalize_acronyms(input)
    assert_equal expected, result
  end

  def test_capitalize_multiple_acronyms
    input = "mtv and bbc news"
    expected = "MTV and BBC news"
    result = MovieListFormatter::Acronyms.capitalize_acronyms(input)
    assert_equal expected, result
  end

  def test_format_title_with_acronyms
    input = "mtv unplugged pearl jam 1992"
    expected = "MTV unplugged pearl jam (1992)"
    result = MovieListFormatter::TextFormatter.format_title(input)
    assert_equal expected, result
  end

  # Test DateUtils module
  def test_extract_date
    date = MovieListFormatter::DateUtils.extract_date(@sample_movie_line)
    expected_date = Date.parse("2024-09-18")
    assert_equal expected_date, date
  end

  def test_extract_movie_name
    movie_name = MovieListFormatter::DateUtils.extract_movie_name(@sample_movie_line)
    expected = "The Matrix (1999)"
    assert_equal expected, movie_name
  end

  def test_format_date_display
    date = Date.parse("2024-09-18")
    formatted = MovieListFormatter::DateUtils.format_date_display(date)
    expected = "September 18, 2024"
    assert_equal expected, formatted
  end

  def test_extract_date_with_invalid_line
    invalid_line = "Some Movie Without Date"
    date = MovieListFormatter::DateUtils.extract_date(invalid_line)
    # Should return default very old date
    expected_date = Date.new(1900, 1, 1)
    assert_equal expected_date, date
  end

end
