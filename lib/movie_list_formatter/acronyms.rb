module MovieListFormatter
  module Acronyms
    # List of acronyms that should be capitalized
    ACRONYMS = %w[
      BBC
      MTV
      DVD
      HD
      FBI
      CIA
      NASA
      IMAX
      TV
      US
      UK
      NYC
      LA
    ].freeze

    # Apply proper capitalization to acronyms in text
    def self.capitalize_acronyms(text)
      result = text
      ACRONYMS.each do |acronym|
        # Use case-insensitive word boundary matching
        result = result.gsub(/\b#{acronym}\b/i, acronym)
      end
      result
    end
  end
end
