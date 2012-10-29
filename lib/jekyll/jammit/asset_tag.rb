# initially pasted from 
# http://mikeferrier.com/2011/04/29/blogging-with-jekyll-haml-sass-and-jammit/

module Jekyll
  module Jammit
    class AssetTag < Liquid::Tag
      def render(context)
        @context = context
        if environment == 'production'
          html "#{jekyll_base_url}/#{::Jammit.package_path}/#{name_with_ext}"
        else   
          (expanded_assets.map do |asset|
            html "#{path}/#{asset}"
          end).join("\n")
        end
      end

      def expanded_assets
        if jammit_config[asset_type].include?(asset_name)
          jammit_config[asset_type][asset_name].map do |asset|
            asset.gsub(/#{jekyll_destination}\/(stylesheets|javascripts)\//, '')
          end
        else
          [name_with_ext]
        end
      end

      def name_with_ext
        "#{asset_name}.#{ext}"
      end
      
      def asset_type
        raise NotImplementedError
      end
      
      def asset_name
        raise NotImplementedError
      end
      
      def ext
        raise NotImplementedError
      end
      
      private
      
      def environment
        Jekyll::Jammit.config.environment
      end
      
      def jammit_config
        Jekyll::Jammit.config.jammit_config
      end
      
      def jekyll_config
         @context.registers[:site].config
      end
      
      def jekyll_destination
        File.basename(jekyll_config['destination'])
      end
      
      def jekyll_base_url
        jekyll_config['base_url']
      end
    end
  end
end