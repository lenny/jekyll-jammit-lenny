# inspired by
# http://mikeferrier.com/2011/04/29/blogging-with-jekyll-haml-sass-and-jammit/
require 'jammit'
require 'liquid'

module Jekyll
  module Jammit
    class AssetTag < Liquid::Tag
      def render(context)
        assets = packages.map do |pack|
          package? ? ::Jammit.asset_url(pack, ext, nil, Time.now) : ::Jammit.packager.individual_urls(pack.to_sym, ext.to_sym)
        end.flatten

        assets.map { |asset| asset_tag(asset) }.join("\n")
      end

      private
      
      def package?
        Jekyll::Jammit.config.environment == 'production'
      end
      
      def packages
        raise NotImplementedError
      end

      def ext
        raise NotImplementedError
      end
      
      def asset_tag
        raise NotImplementedError
      end
    end
  end
end
