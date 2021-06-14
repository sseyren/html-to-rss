require "spec-kemal"
require "../src/html-to-rss"

include HtmlToRss

describe HtmlToRss do
  it "renders page for known paths" do
    get "/"
    response.status_code.should eq 200

    get "/#{SCRAPER_TREE[0].path}"
    response.status_code.should eq 200
  end

  it "returns 404 for unknown paths" do
    get "/a-nonexistent-organization-path"
    response.status_code.should eq 404

    get "/a-nonexistent-organization-path/wtf"
    response.status_code.should eq 404

    get "/rss/a-nonexistent-organization-path"
    response.status_code.should eq 404

    get "/rss/a-nonexistent-organization-path/general"
    response.status_code.should eq 404

    get "/rss/a-nonexistent-organization-path/general/wtf"
    response.status_code.should eq 404
  end

  it "returns 404 for known organizations but unknown paths" do
    get "/rss/#{SCRAPER_TREE[0].path}/this-is-not-a-valid-path-for-this-scraper"
    response.status_code.should eq 404
  end

  # i think that's enough
  it "fetches for first scrapers of all organizations that registered" do
    SCRAPER_TREE.each do |org|
      get "/rss/#{org.path}/#{org.scrapers[0].path}"

      response.status_code.should eq 200
      response.content_type.should eq "text/xml"
    end
  end
end
