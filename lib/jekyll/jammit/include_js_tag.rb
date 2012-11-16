require 'jekyll/jammit/asset_tag'

module Jekyll
  module Jammit
    class IncludeJsTag < AssetTag
      def initialize(name, markup, tokens)
        super
        @packages = markup.strip.split(/\s+/)
      end

      def packages
        @packages
      end

      def asset_tag(src)
        %{<script type="text/javascript" src="#{src}"></script>}
      end
      
      def ext
        'js'
      end
    end
  end
end

Liquid::Template.register_tag('include_js', Jekyll::Jammit::IncludeJsTag)
