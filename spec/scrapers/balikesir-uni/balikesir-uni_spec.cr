require "spec"
require "../../../src/scrapers/*"

include RssScrapers

class Case01 < BalikesirUni
  protected def fetch
    File.read("./spec/scrapers/balikesir-uni/case-01-with-dates.html")
  end

  def initialize
    super(
      "eng_comp",
      "Computer Engineering",
      URI.parse "http://www.balikesir.edu.tr/site/tum-birim-duyuru/bilgisayar-muhendisligi-bolumu-293094"
    )
  end
end

class Case02 < BalikesirUni
  protected def fetch
    File.read("./spec/scrapers/balikesir-uni/case-02-without-dates.html")
  end

  def initialize
    super(
      "general",
      "University-Wide Announcements",
      URI.parse "http://www.balikesir.edu.tr/site/tum-duyurular"
    )
  end
end

describe BalikesirUni do
  it "is a BaseScraper" do
    ins = BalikesirUni.new("test", "test", URI.parse "test")
    ins.should be_a BaseScraper
  end

  it "can parse page that contains dates" do
    feed = Case01.new.run
    first = feed.items[0]

    first.link.should eq(
      URI.parse "http://www.balikesir.edu.tr/site/duyuru/5838"
    )
    first.title.should eq(
      "Genç Beyinler Yeni Fikirler Proje Pazarı ve Bitirme Projeleri Sergisi"
    )
    first.guid_is_perma_link.should be_false
    first.guid.should eq(
      URI.parse(
        "63a4dc2054eda58efc13d481356346061fb679e63851f9d424d82331317faa27"
      )
    )
    first.pub_date.should eq Time.local(
      2021, 6, 2,
      location: Time::Location.load("Europe/Istanbul")
    )
  end

  it "can parse page that contains incomplete dates" do
    feed = Case02.new.run
    first = feed.items[0]

    first.link.should eq(
      URI.parse "http://www.balikesir.edu.tr/site/duyuru/5875"
    )
    first.title.should eq(
      "Görevde Yükselme Memur Sözlü Sınavı"
    )
    first.guid_is_perma_link.should be_false
    first.guid.should eq(
      URI.parse(
        "374eae815bb1d0c384b54e6d03a173e065d90e2ab60121221eef067c798bcd94"
      )
    )
    first.pub_date.should be_nil
  end
end
