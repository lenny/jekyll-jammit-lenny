require 'spec_helper'

require 'liquid'
require 'jekyll-jammit'

module Jekyll
  module Jammit
    describe IncludeJsTag do
      let(:jekyll_config) { double('Jekyll Config').as_null_object }
      let(:site) { double('Jekyll Site', :config => jekyll_config).as_null_object }

      subject do
        IncludeJsTag.new('include_js', 'application', [])
      end
      
      it 'includes javascripts relative to jekyll site destination' do
        Jekyll::Jammit.configure do |c|
          c.jammit_config = {
            'javascripts' => {
              'application' => ['_site/javascripts/file1.js'
            }
          }
        end
        subject.
        rendered.should include_line_matching(/<script src=.*file1.js/)
        rendered.should include_line_matching(/<script src=.*file2.js/)
      end
    end
  end
end