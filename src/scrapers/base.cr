
module RssScrapers

    class BaseScraper
      DEFAULT_TIMEOUT = 15 # seconds
      getter path, title, target

      def initialize(@path : String, @title : String, @target : URI)
      end

      def run
        raise NotImplementedError.new "run"
      end

    end

    class FailedRequestException < Exception
      def initialize(
        message = "During execution, one of the requests has been failed."
      )
      super(message)
      end
    end

  end