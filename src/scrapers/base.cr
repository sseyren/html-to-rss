
module RssScrapers

    class BaseScraper
      DEFAULT_TIMEOUT = 15 # seconds
      getter path, title, target
  
      def initialize(@path : String, @title : String, @target : String)
      end
  
      def run
      end
  
    end
  
  end