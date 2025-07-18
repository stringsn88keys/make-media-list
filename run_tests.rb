#!/usr/bin/env ruby

# Simple test runner that runs all tests in the test directory
Dir.glob(File.join(__dir__, 'test', 'test_*.rb')).each do |test_file|
  require test_file
end
