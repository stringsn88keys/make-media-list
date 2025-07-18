module MovieListFormatter
  module TextFormatter
    # Function to capitalize Roman numerals
    def self.capitalize_roman_numerals(text)
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
    def self.format_years(text)
      # Match 4-digit years (1900-2099)
      text.gsub(/\b(19|20)\d{2}\b/) { |year| "(#{year})" }
    end

    # Convert filename to title case
    def self.filename_to_title_case(filename)
      # Get filename without extension
      name_without_ext = File.basename(filename, ".*")
      
      # Convert to title case
      name_without_ext.downcase.split(/[\s_-]+/).map(&:capitalize).join(' ')
    end

    # Apply all text formatting
    def self.format_title(text)
      result = text
      result = capitalize_roman_numerals(result)
      result = format_years(result)
      result = MovieListFormatter::Acronyms.capitalize_acronyms(result)
      result
    end
  end
end
