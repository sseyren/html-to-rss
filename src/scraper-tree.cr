require "uri"
require "./scrapers/*"

module HtmlToRss
  include RssScrapers

  class Organization
    getter path, name, scrapers

    def initialize(
      @path : String,
      @name : String,
      @scrapers : Array(BaseScraper)
    )
    end
  end

  @@scraper_tree = [
    Organization.new(
      path: "balikesir-uni",
      name: "Balıkesir University",
      scrapers: [
        BalikesirUni.new(
          path: "general",
          title: "University-Wide Announcements",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-duyurular",
        ),
        BalikesirUni.new(
          path: "eng",
          title: "Engineering Faculty",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/muhendislik-fakultesi-293092",
        ),
        BalikesirUni.new(
          path: "eng_comp",
          title: "Computer Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/bilgisayar-muhendisligi-bolumu-293094",
        ),
      ] of BaseScraper,
    )
  ] of Organization
end