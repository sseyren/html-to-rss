require "uri"
require "http/client"
require "digest/sha256"
require "myhtml"
require "cryss"

require "./base"

module RssScrapers
  class BalikesirUni < BaseScraper
    TIME_LOC = Time::Location.load("Europe/Istanbul")

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

    protected def fetch
      client = set_timeout HTTP::Client.new(@target)
      headers = nil

      if @target.query.to_s.includes? "tum-birim-duyuru"
        ref_target = @target.normalize
        ref_target.query = ref_target.query.to_s.sub("tum-birim-duyuru", "birim")
        ref = client.get(ref_target.to_s)

        headers = ref.cookies.add_request_headers(HTTP::Headers.new)
        headers.add("Referer", ref_target.to_s)
      end

      response = client.get(@target.to_s, headers)
      if !response.success?
        raise FailedRequestException.new
      end

      client.close
      response.body
    end

    def run
      response = fetch

      feed = RSS::Channel.new(
        link: @target,
        title: "BAUN #{@title}",
        description: "RSS feed for #{@title} @ Balikesir University",
      )
      feed.language = "tr"
      feed.last_build_date = Time.local(TIME_LOC)
      feed.webmaster = "thesseyren@gmail.com (Serhat Seyren)"

      parser = Myhtml::Parser.new(response)
      container = parser.css(".pi-section .pi-row").first

      container.children.nodes(:div).each do |entry|
        h = entry.children.nodes(:h2).first
        a = h.children.nodes(:a).first
        header, path = a.inner_text.strip, a.attribute_by("href").to_s.strip

        item = RSS::Item.new(header)
        item.link = URI.parse("#{@target.scheme}://#{@target.host}#{path}")
        item.guid_is_perma_link = false
        item.guid = URI.parse(Digest::SHA256.hexdigest("#{path} #{header}"))

        div = entry.children.nodes(:div).first
        d = div.inner_text.strip.split(" ").select { |x| !x.empty? }

        if d.size == 3
          item.pub_date = Time.local(
            d[2].to_i, MONTHS[d[1]], d[0].to_i, location: TIME_LOC)
        end

        feed << item
      end

      feed
    end
  end
end
