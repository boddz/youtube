# Youtube Data Extractor

A Ruby gem for extracting youtube video data.

This does not use the API that google provides, this is just data gathered from scraping raw HTML data. No reason
really, I just find doing so more fun.

This gem is still in it's earlier stages of development so expect stuff to change. I will try not to change too much
in terms of interface methods/ classes that can break your existing scripts for convenience sake.


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

For some examples on how to use this gem go and check out the `examples` sub-directory.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Running tests:

```bash
cd tests  # These commands must be run in ./tests for relative path reasons.
./data/get_data  # Fetch data used in test. Used for mocked session objects to avoid sending requests when testing.
ruby test_all.rb  # To run all tests, or you can just call an individual test instead.
```


## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/boddz/youtube).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
