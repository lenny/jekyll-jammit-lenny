require "jekyll-jammit/version"
require 'jekyll/jammit/include_js_tag'
require 'jekyll/jammit/include_css_tag'
require 'jekyll/jammit/config'

module Jekyll
  module Jammit
    class << self
      attr_reader :config
      
      def configure(&blk)
        @config = Jekyll::Jammit::Config.new
        yield(config)
      end
    end
  end
end
