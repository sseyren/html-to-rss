# html-to-rss

This project aims to parse HTML page and generate a RSS feed from it. That's it.
RSS is a great thing to have, whenever something changes in a website you will
be notified. I don't want to go and check websites regularly. A computer/mobile
device should do this, not me.

## Installation

Get the
[latest release](https://github.com/thesseyren/html-to-rss/releases/latest).

## Usage

Environment variables:
- `KEMAL_ENV`: (Optional) It's because this project uses
[Kemal](https://kemalcr.com). Options; `development`, `production`, `test`.
- `HTMLTORSS_HOST`: (Optional) Hostname for generated urls.
Example; `HTMLTORSS_HOST='https://mywebsite.com'`

You can use `--help` to get command line arguments.

## Development

A new scraper needs to be in `RssScrapers` module, based on
`RssScrapers::BaseScraper` and should be in `src/scrapers/`. After that, It
needs to be registered in `HtmlToRss::SCRAPER_TREE` constant.

### Testing

Scraper test scripts needs to be in `spec/scrapers/`. A new folder can be
created for a scraper. One or more HTML examples can be located in this folder.

This project uses [Kemal](https://kemalcr.com), so you need to test this with a
environment variable:
```sh
$ KEMAL_ENV=test crystal spec
```

## Contributing

1. Fork it (<https://github.com/thesseyren/html-to-rss/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Serhat Seyren](https://github.com/thesseyren) - creator and maintainer

## License

MIT