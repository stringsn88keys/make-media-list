require 'rake/testtask'

# Define test task
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/test_*.rb']
end

# Default task
task default: :test

# Custom tasks for the movie list scripts
desc "Scan directory for MKV files and create initial list"
task :scan do
  ruby "mkv_formatter.rb"
end

desc "Format movie list with dates and enhanced formatting"
task :format do
  ruby "format_list.rb"
end

desc "Group formatted movie list by date"
task :group_by_date do
  ruby "format_list_by_date.rb"
end

desc "Run complete formatting pipeline"
task :all => [:scan, :format, :group_by_date]

desc "Show current project structure"
task :structure do
  puts "Project Structure:"
  puts "==================="
  puts "lib/                    - Shared modules and utilities"
  puts "  module_name.rb        - Main module file (loads submodules)"
  puts "  module_name/          - Submodule directory"
  puts "    submodule.rb        - Individual module components"
  puts "test/                   - Test files (test_*.rb)"
  puts "*.rb                    - Main executable scripts"
  puts "*.txt                   - Data files (input/output)"
  puts "Rakefile                - Build automation"
  puts "README.md               - Documentation"
  puts ""
  puts "Load Path Management:"
  puts "- Scripts add lib/ to $LOAD_PATH"
  puts "- Use simple 'require' instead of require_relative"
  puts "- Module files manage their own subdirectories"
end
