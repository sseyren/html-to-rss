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

  SCRAPER_TREE = [
    Organization.new(
      path: "balikesir-uni",
      name: "Balıkesir University",
      scrapers: [
        BalikesirUni.new(
          path: "general",
          title: "University-Wide Announcements",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-duyurular",
        ),
        BalikesirUni.new(
          path: "arch",
          title: "Faculty of Architecture",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=mimarlik-fakultesi&id=293093",
        ),
        BalikesirUni.new(
          path: "arch_arch",
          title: "Department of Architecture",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=mimarlik-bolumu&id=293108",
        ),
        BalikesirUni.new(
          path: "eng",
          title: "Faculty of Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=muhendislik-fakultesi&id=293092",
        ),
        BalikesirUni.new(
          path: "eng_comp",
          title: "Computer Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=bilgisayar-muhendisligi-bolumu&id=293094",
        ),
        BalikesirUni.new(
          path: "eng_env",
          title: "Environmental Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=cevre-muhendisligi-bolumu&id=293097",
        ),
        BalikesirUni.new(
          path: "eng_ee",
          title: "Electrical & Electronic Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=elektrik-elektronik-muhendisligi-bolumu&id=293098",
        ),
        BalikesirUni.new(
          path: "eng_ind",
          title: "Industrial Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=endustri-muhendisligi-bolumu&id=293100",
        ),
        BalikesirUni.new(
          path: "eng_food",
          title: "Food Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=gida-muhendisligi-bolumu&id=293101",
        ),
        BalikesirUni.new(
          path: "eng_const",
          title: "Constructional Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=insaat-muhendisligi-bolumu&id=293102",
        ),
        BalikesirUni.new(
          path: "eng_geo",
          title: "Geological Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=jeoloji-muhendisligi-bolumu&id=293103",
        ),
        BalikesirUni.new(
          path: "eng_mechanical",
          title: "Mechanical Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=makine-muhendisligi-bolumu&id=293104",
        ),
        BalikesirUni.new(
          path: "eng_mechatronics",
          title: "Mechatronics Engineering",
          target: URI.parse "http://www.balikesir.edu.tr/index.php?r=site%2Ftum-birim-duyuru&name=mekatronik-muhendisligi-bolumu&id=293105",
        ),
      ] of BaseScraper,
    ),
  ] of Organization
end
