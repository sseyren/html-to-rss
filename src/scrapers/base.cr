
module RssScrapers

    class BaseScraper
      DEFAULT_TIMEOUT = 15 # seconds
      getter path, title, target

      def initialize(@path : String, @title : String, @target : URI)
      end

      # Should call this method whenever a `HTTP::Client` constructed.
      protected def set_timeout(
        client : HTTP::Client,
        timeout = DEFAULT_TIMEOUT,
      )
        client.connect_timeout = timeout
        client.dns_timeout = timeout
        client.read_timeout = timeout
        client.write_timeout = timeout
        client
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