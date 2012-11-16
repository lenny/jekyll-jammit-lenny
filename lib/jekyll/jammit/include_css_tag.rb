require 'jekyll/jammit/asset_tag'

module Jekyll
  module Jammit
    class IncludeCssTag < AssetTag
      def initialize(name, markup, tokens)
        super
        @asset_name, *@media = markup.strip.split(/\s+/)
        @media << 'screen' if @media.empty?
      end

      def packages
        [@asset_name]
      end
      
      def asset_tag(src)
        %{<link href="#{src}" media="#{@media.join(' ')}" rel='stylesheet' type='text/css' />}
      end
      
      def ext
        'css'
      end
    end
  end
end

Liquid::Template.register_tag('include_css', Jekyll::Jammit::IncludeCssTag)