# Jekyll::Jammit

Jammit asset packaging integration for Jekyll

## Installation

Add this line to your application's Gemfile:

    gem 'jekyll-jammit-lenny'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-jammit-lenny

## Usage

    <head>
        ....
	{% include_css application screen %}
	{% include_css print print %}
	{% include_js application %}
    </head>

Somewhere in _plugins/

    Jekyll::ENV = (ENV['JEKYLL_ENV'] || 'development')
    
    require 'jekyll-jammit'
    
    Jekyll::Jammit.configure do |c|
      c.environment = ENV['JEKYLL_ENV'] || 'development'
      c.jammit_config_path = '_config/assets.yml'
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
