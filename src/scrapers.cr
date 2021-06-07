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
      name: "Balıkesir Üniversitesi",
      scrapers: [
        BalikesirUni.new(
          path: "eng_comp",
          title: "Computer Engineering",
          target: "/site/tum-birim-duyuru/bilgisayar-muhendisligi-bolumu-293094",
        )
      ] of BaseScraper,
    )
  ] of Organization
end