require "kemal"

require "./scraper-tree"

# TODO: Write documentation for `HtmlToRss`
module HtmlToRss
  extend self
  VERSION = "0.1.0"

  macro render_template(filename)
    render "src/views/#{{{filename}}}.ecr", "src/views/base.ecr"
  end

  def raise_404(env)
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end

  def add_charset(env, charset="utf-8")
    if !env.response.headers["Content-Type"].includes? "charset="
      env.response.headers["Content-Type"] += "; charset=#{charset}"
    end
  end

  before_all {|env| add_charset env}
  after_all {|env| add_charset env}

  error 404 do |env, exc|
    render_template "error"
  end

  get "/" do |env|
    orgs = @@scraper_tree
    render_template "index"
  end

  get "/:org" do |env|
    org = @@scraper_tree.find {|i| i.path == env.params.url["org"]}

    if org.nil?
      raise_404 env
    end

    full_host = if ENV.has_key? "HTMLTORSS_HOST"
      ENV["HTMLTORSS_HOST"]
    elsif env.request.headers.has_key? "Host"
      "https://#{env.request.headers["Host"]}"
    else
      "http://localhost"
    end

    render_template "organization"
  end

  get "/rss/:org/:endpoint" do |env|
    org = @@scraper_tree.find {|i| i.path == env.params.url["org"]}

    if org.nil?
      raise_404 env
    else
      scraper = org.scrapers.find {|i| i.path == env.params.url["endpoint"]}
      if scraper.nil?
        raise_404 env
      else
        begin
          resp = scraper.run
        rescue ex
          render_500 env, ex, true
        else
          env.response.content_type = "text/xml"
          resp.to_s
        end
      end
    end
  end

  Kemal.run

end
