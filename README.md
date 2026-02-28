# OmniAuth Notion Strategy

This gem provides a simple way to authenticate to Notion using OmniAuth with OAuth2.

> **OmniAuth version compatibility**
> - `omniauth-notion >= 1.0` requires OmniAuth 2.x
> - `omniauth-notion ~> 0.0.3` supports OmniAuth 1.x (no longer maintained)

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

## Releasing

Releases are published to RubyGems automatically via GitHub Actions using [trusted publishing](https://guides.rubygems.org/trusted-publishing/).

To release a new version:

1. Update the version in `lib/omniauth-notion/version.rb`
2. Update `CHANGELOG.md`
3. Commit and push to `master`
4. Tag and push: `git tag v1.x.x && git push origin v1.x.x`

The `v*` tag push triggers the release workflow, which builds and publishes the gem.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
