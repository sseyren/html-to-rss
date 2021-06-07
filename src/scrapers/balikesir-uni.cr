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

    def run
      client = HTTP::Client.new(@target)
      headers = nil

      if @target.path.includes? "/tum-birim-duyuru/"
        ref_path = @target.path.sub("/tum-birim-duyuru/", "/birim/")
        ref = client.get(ref_path)

        headers = ref.cookies.add_request_headers(HTTP::Headers.new())
        headers.add(
          "Referer",
          "#{@target.scheme}://#{@target.host}/#{ref_path}"
        )
      end

      res = client.get(@target.path, headers)
      if !res.success?
        raise FailedRequestException.new
      end

      client.close()

      feed = RSS::Channel.new(
        link: @target,
        title: "BAUN #{@title}",
        description: "RSS feed for #{@title} @ Balikesir University",
      )
      feed.language = "tr"
      feed.last_build_date = Time.local(TIME_LOC)
      feed.webmaster = "thesseyren@gmail.com (Serhat Seyren)"

      parser = Myhtml::Parser.new(res.body)
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
        d = div.inner_text.strip.split(" ").select {|x| !x.empty?}

        if d.size == 3
          item.pub_date = Time.local(
            d[2].to_i, MONTHS[d[1]], d[0].to_i, location:TIME_LOC)
        end

        feed << item
      end

      feed
    end

  end

end