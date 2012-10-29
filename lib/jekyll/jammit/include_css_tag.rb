require 'jekyll/jammit/asset_tag'

module Jekyll
  module Jammit
    class IncludeCssTag < AssetTag
      def initialize(name, markup, tokens)
        super
        @asset_name, *@media = markup.strip.split(/\s+/)
        @media << 'screen' if @media.empty?
        @asset_name.sub!(/\.css$/, '')
      end

      def html(src)
        %{<link href="#{src}" media="#{@media.join(' ')}" rel="stylesheet" type="text/css" />}
      end

      def asset_name
        @asset_name
      end

      def asset_type
        'stylesheets'
      end

      def ext
        'css'
      end

      def path
        '/stylesheets'
      end
    end
  end
end

Liquid::Template.register_tag('include_css', Jekyll::Jammit::IncludeCssTag)