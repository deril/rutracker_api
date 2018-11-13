# Rutracker API - gem for easy querying rutracker

## Description

Rutracker API is useful gem if you need to query some seeds on Rutracker.org

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rutracker_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rutracker_api
    
## Usage

You have to have registration on http://rutracker.org
In code:

  ```ruby
# create client for parsing. Put there login and password from your account
client = RutrackerApi.new('my_login', 'my_pass')

#create request ro rutracker
client.search(category: 7, sort: :ask, order_by: :date, term: 'Superman')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deril/rutracker_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rutracker API project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/deril/rutracker_api/blob/master/CODE_OF_CONDUCT.md).
