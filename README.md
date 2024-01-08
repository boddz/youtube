# Youtube Data Extractor

A ruby gem for extracting youtube video data.

Currently a work in progress. This is just a mirror at the moment so support will be limited because of this for now,
and I am still new to Ruby, so some things will be changed a lot in the future most likely.


## Installation

Written and tested with and `ruby 3.0.2` on `Ubuntu 22.04.3 LTS`.

Install required gems:

```bash
bundle install
```

Build and install gem file locally:

```bash
gem build && gem install youtube-data-[version].gem
```

Or install from gem server:

```bash
gem install youtube-data
```


## Usage

TODO: Write usage instructions here...


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Running tests:

```bash
cd tests  # These commands must be run in ./tests for relative path reasons.
ruby test_all.rb  # To run all tests, or you can just call an individual test instead.
```


## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/boddz/youtube).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
