# OmniAuth Notion Strategy

This gem provides a simple way to authenticate to Notion using OmniAuth with OAuth2.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-notion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-notion

## Usage

1. Get your client key & secret from notion [here](https://www.notion.so/my-integrations)
2. configure omniauth or Devise or whatever you're using to use this as another oauth provider.

This looks something like below for Devise.
```ruby
Devise.setup do |config|
  ...
  config.omniauth :notion, ENV['NOTION_CLIENT_KEY'], ENV['NOTION_CLIENT_SECRET']
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
