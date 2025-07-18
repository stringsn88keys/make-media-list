module MovieListFormatter
  module ProgressReporter
    def self.report_progress(current, total, item_name)
      puts "Processing #{current}/#{total}: #{item_name}"
    end

    def self.report_completion(total_items, output_file)
      puts "\nProcessing complete!"
      puts "Updated #{total_items} entries"
      puts "Output written to: #{output_file}"
    end

    def self.report_grouping_stats(total_movies, total_dates, output_file)
      puts "\nProcessing complete!"
      puts "Grouped #{total_movies} movies by #{total_dates} different dates"
      puts "Output written to: #{output_file}"
    end
  end
end
