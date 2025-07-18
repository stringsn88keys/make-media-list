# make-media-list

Scripts for formatting and organizing movie lists with dates.

## Project Structure

```
make-media-list/
├── lib/
│   ├── movie_list_formatter.rb        # Main module (loads submodules)
│   └── movie_list_formatter/          # Submodule directory
│       ├── file_utils.rb              # File I/O utilities
│       ├── text_formatter.rb          # Text formatting utilities
│       ├── acronyms.rb                # Acronym capitalization
│       ├── date_utils.rb              # Date handling utilities
│       └── progress_reporter.rb       # Progress reporting
├── test/
│   └── test_movie_list_formatter.rb   # Test suite
├── mkv_formatter.rb                   # Main scripts
├── format_list.rb
├── format_list_by_date.rb
├── run_tests.rb                       # Test runner
├── Rakefile                           # Build automation
└── *.txt                              # Data files
```

## Architecture

The project uses a hierarchical module structure with proper load path management:

### Module Hierarchy
- **Main Module** (`lib/movie_list_formatter.rb`): Sets up load paths and requires submodules
- **Submodules** (`lib/movie_list_formatter/`): Individual functional components
- **Load Path Management**: Scripts add `lib/` to `$LOAD_PATH` for clean requires

### Benefits
- **Clean Requires**: Simple `require 'module_name'` instead of relative paths
- **Organized Code**: Related functionality grouped in submodules
- **Scalable**: Easy to add new submodules as the project grows
- **Standard Patterns**: Follows Ruby community conventions-list

Scripts for formatting and organizing movie lists with dates.

## Files

### movie_list_formatter.rb
A shared module containing common functionality used by all format scripts:
- **FileUtils**: File reading/writing and platform-specific path handling
- **TextFormatter**: Roman numeral capitalization, year formatting, acronym capitalization, and filename-to-title conversion
- **DateUtils**: Date extraction, parsing, and file timestamp handling
- **ProgressReporter**: Consistent progress and completion reporting

### mkv_formatter.rb
A script that scans a directory for MKV files and creates an initial formatted list. It:
- Scans the video directory for .mkv files
- Converts filenames to title case (removing underscores, hyphens)
- Sorts the list alphabetically
- Outputs to `formatted_mkv_list.txt`

### format_list.rb
The original script that processes movie titles and adds creation dates. It:
- Capitalizes Roman numerals (II, III, IV, etc.)
- Formats years with parentheses
- Adds creation dates based on file system timestamps
- Outputs to `formatted_mkv_list_updated.txt`

### format_list_by_date.rb
A script that groups movies by the date they were added, in descending order (newest first). It:
- Reads from `formatted_mkv_list_updated.txt`
- Groups movies by their "added YYYY-MM-DD" dates
- Sorts dates in descending order (most recent first)
- Sorts movies alphabetically within each date group
- Outputs to `formatted_mkv_list_by_date.txt`
- Provides a summary of dates and movie counts

## Configuration

The project uses a configuration file to manage paths and settings:

### Setup Configuration
```bash
# Create configuration file from example
rake setup_config

# Edit the configuration file
vim .config.rb
```

### Configuration Options
- **Video Paths**: Platform-specific paths for video directories
- **File Names**: Customizable input/output file names
- **Platform Detection**: Automatic path selection based on `RUBY_PLATFORM`

The configuration file supports:
- Windows: `\\\\videos\\media`
- macOS: `/Volumes/Media`  
- Linux/Unix: `/videos/media`
- Custom paths: Override with your specific directories

## Usage

### Command Line
```bash
# Scan directory and create initial formatted list
ruby mkv_formatter.rb

# Format the list with dates and enhanced formatting
ruby format_list.rb

# Group the formatted list by date
ruby format_list_by_date.rb
```

### Using Rake (Recommended)
```bash
# Setup configuration (first time only)
rake setup_config

# Run individual steps
rake scan              # Scan for MKV files
rake format            # Format with dates
rake group_by_date     # Group by date

# Run complete pipeline
rake all

# Run tests
rake test

# Show project structure
rake structure
```

### Testing
```bash
# Run all tests
ruby run_tests.rb
# OR
rake test
```

## Architecture

The project uses a modular design where common functionality is extracted into `movie_list_formatter.rb`. This provides:
- **Code reuse**: Shared utilities across multiple scripts
- **Consistency**: Same formatting and date handling logic everywhere
- **Maintainability**: Changes to core logic only need to be made in one place
- **Testability**: Each module can be tested independently

## Output Format

The date-grouped output format looks like:
```
============================================================
ADDED ON JULY 18, 2025
============================================================

Movie Title 1
Movie Title 2
...

============================================================
ADDED ON JULY 03, 2025
============================================================

Movie Title 3
...
```

## Text Formatting Features

The `text_formatter.rb` module provides comprehensive text formatting:

- **Roman Numerals**: Uppercase I, II, III, IV, V, etc.
- **Years**: Handles various year patterns in different contexts
- **Acronyms**: Capitalizes common acronyms like BBC, MTV, DVD, HD, TV, etc.
- **Word Boundaries**: Ensures acronyms are only capitalized when they appear as complete words

### Adding New Acronyms

To add new acronyms for capitalization, edit `lib/movie_list_formatter/acronyms.rb`:

```ruby
ACRONYMS = %w[
  BBC MTV DVD HD TV US UK NYC LA FBI CIA NASA IMAX
  # Add your new acronyms here
].freeze
```
