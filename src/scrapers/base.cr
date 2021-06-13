
module RssScrapers

  class BaseScraper
    getter path, title, target

    # Default timeout for HTTP requests.
    DEFAULT_TIMEOUT = 15 # seconds

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

    # Method for the scraper to go and fetch the data that will be parsed.
    # This method should be called from `#run` method and should return
    # `String`.
    protected def fetch
      raise NotImplementedError.new "fetch"
    end

    # This is the main method for the scraper.
    # Should return `RSS::Channel` instance.
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