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
          path: "arch",
          title: "Faculty of Architecture",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/mimarlik-fakultesi-293093",
        ),
        BalikesirUni.new(
          path: "arch_arch",
          title: "Department of Architecture",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/mimarlik-bolumu-293108",
        ),
        BalikesirUni.new(
          path: "eng",
          title: "Faculty of Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/muhendislik-fakultesi-293092",
        ),
        BalikesirUni.new(
          path: "eng_comp",
          title: "Computer Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/bilgisayar-muhendisligi-bolumu-293094",
        ),
        BalikesirUni.new(
          path: "eng_env",
          title: "Environmental Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/cevre-muhendisligi-bolumu-293097",
        ),
        BalikesirUni.new(
          path: "eng_ee",
          title: "Electrical & Electronic Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/elektrik-elektronik-muhendisligi-bolumu-293098",
        ),
        BalikesirUni.new(
          path: "eng_ind",
          title: "Industrial Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/endustri-muhendisligi-bolumu-293100",
        ),
        BalikesirUni.new(
          path: "eng_food",
          title: "Food Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/gida-muhendisligi-bolumu-293101",
        ),
        BalikesirUni.new(
          path: "eng_const",
          title: "Constructional Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/insaat-muhendisligi-bolumu-293102",
        ),
        BalikesirUni.new(
          path: "eng_geo",
          title: "Geological Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/jeoloji-muhendisligi-bolumu-293103",
        ),
        BalikesirUni.new(
          path: "eng_mechanical",
          title: "Mechanical Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/makine-muhendisligi-bolumu-293104",
        ),
        BalikesirUni.new(
          path: "eng_mechatronics",
          title: "Mechatronics Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/mekatronik-muhendisligi-bolumu-293105",
        ),
      ] of BaseScraper,
    ),
  ] of Organization
end