require "kemal"

require "./scrapers"

# TODO: Write documentation for `HtmlToRss`
module HtmlToRss
  VERSION = "0.1.0"

  get "/" do |env|
    "merhaba"
  end

  get "/:org" do |env|
    org = @@scraper_tree.find {|i| i.path == env.params.url["org"]}

    if org.nil?
      render_404
    else
      org.name
    end
  end

  get "/rss/:org/:endpoint" do |env|
    org = @@scraper_tree.find {|i| i.path == env.params.url["org"]}

    if org.nil?
      render_404
    else
      scraper = org.scrapers.find {|i| i.path == env.params.url["endpoint"]}
      if scraper.nil?
        render_404
      else
        env.response.content_type = "text/xml"
        scraper.run
      end
    end
  end

  Kemal.run

end
