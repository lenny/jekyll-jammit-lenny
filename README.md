# Jekyll::Jammit

Jammit asset packaging integration for Jekyll

Originally inspired by http://mikeferrier.com/2011/04/29/blogging-with-jekyll-haml-sass-and-jammit/

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
	{% include_js application %}
    </head>

In development mode (i.e. JEKYLL_ENV != 'production') the above translates to something like:

    <link type="text/css" rel="stylesheet" media="screen" href="/stylesheets/screen.css">
    <script src="/javascripts/jquery-1.8.2.min.js" type="text/javascript">
    <script src="/javascripts/bootstrap.min.js" type="text/javascript">
    <script src="/javascripts/application.js" type="text/javascript">
    
In production (i.e. JEKYLL_ENV == 'production') it would be:

    <link type="text/css" rel="stylesheet" media="screen" href="/assets/application.css?1353040689">
    <script src="/assets/application.js?1353040689" type="text/javascript">

## Configuration

Somewhere in _plugins/

    # e.g. _plugins/env.rb
    Jekyll::ENV = (ENV['JEKYLL_ENV'] || 'development')
    
    require 'jekyll-jammit'
    
    Jekyll::Jammit.configure do |c|
      c.environment = ENV['JEKYLL_ENV'] || 'development'
      
      # Path to Jammit configuration file. See http://documentcloud.github.com/jammit/
      c.jammit_config_path = '_config/assets.yml'
    end
    
## Compiling site for production

I use a rake task like the one below:

    desc "Package app for production"
    task :package do
      ENV['JEKYLL_ENV'] = 'production'
      Rake::Task[:compile].invoke
      require 'jammit'
      ::Jammit.package!(:public_root => '_site', :config_path => '_config/assets.yml')
    end
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
