require 'jekyll/jammit/asset_tag'

module Jekyll
  module Jammit
    class IncludeJsTag < AssetTag
      def initialize(name, markup, tokens)
        super
        @asset_name = markup.strip.sub(/\.js$/, '')
      end

      def html(src)
        %{<script src='#{src}' type='text/javascript'></script>}
      end

      def asset_name
        @asset_name
      end

      def asset_type
        'javascripts'
      end

      def ext
        'js'
      end

      def path
        '/javascripts'
      end
    end
  end
end

Liquid::Template.register_tag('include_js', Jekyll::Jammit::IncludeJsTag)
