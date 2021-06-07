require "http/client"
require "digest/sha256"
require "myhtml"
require "cryss"

require "./base"

module RssScrapers

  class BalikesirUni < BaseScraper
    TIME_LOC = Time::Location.load("Europe/Istanbul")
    HOST = "www.balikesir.edu.tr"
    REF_PATH = "/site/birim/bilgisayar-muhendisligi-bolumu-293094"

    MONTHS = {
      "ARA": 12,
      "KAS": 11,
      "EKİ": 10,
      "EYL": 9,
      "AĞU": 8,
      "TEM": 7,
      "HAZ": 6,
      "MAY": 5,
      "NİS": 4,
      "MAR": 3,
      "ŞUB": 2,
      "OCA": 1,
    }

    def run
      client = HTTP::Client.new(HOST)
      ref = client.get(REF_PATH)
      #p! ref.success?

      headers = ref.cookies.add_request_headers(HTTP::Headers.new())
      headers.add("Referer", "http://#{HOST}#{REF_PATH}")
      #p! headers

      res = client.get(@target, headers)
      #p! ref.success?

      html = res.body
      client.close()

      feed = RSS::Channel.new(
        link: "http://#{HOST}#{@target}",
        title: "BAUN #{@title}",
        description: "RSS feed for #{@title} @ Balikesir University",
      )

      parser = Myhtml::Parser.new(html)
      container = parser.css(".main-content .pi-section .pi-row").first

      container.children.nodes(:div).each do |entry|
        div = entry.children.nodes(:div).first
        d, m, y = div.inner_text.strip.split(" ").select {|x| !x.empty?}
        d, m, y = d.to_i, MONTHS[m], y.to_i
        time = Time.local(y, m, d, location:TIME_LOC)

        h = entry.children.nodes(:h2).first
        a = h.children.nodes(:a).first
        header, path = a.inner_text.strip, a.attribute_by("href").to_s.strip

        item = RSS::Item.new(header)
        item.link = URI.parse("http://#{HOST}#{path}")
        item.guid_is_perma_link = false
        item.guid = URI.parse(Digest::SHA256.hexdigest("#{path} #{header}"))
        item.pub_date = time

        feed << item
      end

      feed.to_s

    end

  end

end