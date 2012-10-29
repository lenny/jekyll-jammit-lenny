require 'spec_helper'

require 'jekyll'
require 'jekyll-jammit'

describe 'Jekyll Jammit' do
  let(:config) { Jekyll.configuration(:destination => '_site') }
  let(:site) { Jekyll::Site.new(config) }
  
  def render_template(liquid)
    template = Liquid::Template.parse(liquid)
    template.render({}, { :registers => { :site => site } })
  end
  
  describe 'include_js' do
    it 'includes javascript files individually in development' do
      Jekyll::Jammit.configure do |c|
        c.environment = 'development'
        c.jammit_config = {
          'javascripts' => {
            'application' => ['_site/javascripts/file1.js', '_site/javascripts/file2.js']
          }
        }
      end
      rendered = render_template('{% include_js application.js %}')
      rendered.should include_line_matching(/<script src=.*file2.js/)
      rendered.should include_line_matching(/<script src=.*file2.js/)
    end
    
    it 'includes concatenated javascripts in production' do
      Jekyll::Jammit.configure do |c|
        c.environment = 'production'
        c.jammit_config = {
          'javascripts' => {
            'application' => ['_site/javascripts/file1.js', '_site/javascripts/file2.js']
          }
        }
      end
      rendered = render_template('{% include_js application.js %}')
      rendered.should include_line_matching(/<script src=.*application.js/)
    end
    
    specify 'javascripts are :jekyll_destination_dir/:jammit_package_path/:file.js in production'
  end
  
  describe 'include_css' do
    it 'includes stylesheets individually in development' do
      Jekyll::Jammit.configure do |c|
        c.environment = 'development'
        c.jammit_config = {
          'stylesheets' => {
            'application' => ['_site/stylesheets/file1.css', '_site/stylesheets/file2.css']
          }
        }
      end
      rendered = render_template('{% include_css application.css %}')
      rendered.should include_line_matching(/<link href=.*file2.css/)
      rendered.should include_line_matching(/<link href=.*file2.css/)
    end
    
    it 'includes concatenated stylesheets in production' do
      Jekyll::Jammit.configure do |c|
        c.environment = 'production'
        c.jammit_config = {
          'stylesheets' => {
            'application' => ['_site/stylesheets/file1.css', '_site/stylesheets/file2.css']
          }
        }
      end
      rendered = render_template('{% include_css application.css %}')
      rendered.should include_line_matching(/<link href=.*application.css/)
    end
    
    specify 'media attribute can be specified in tag' do
      Jekyll::Jammit.configure do |c|
        c.environment = 'development'
        c.jammit_config = {
          'stylesheets' => { 'foo' => ['_site/stylesheets/file1.css', '_site/stylesheets/file2.css'] }
        }
      end
      template = Liquid::Template.parse('{% include_css foo.css screen projection %}')
      rendered = template.render({}, { :registers => { :site => site } })
      rendered.should include_line_matching(/<link.*media=.*screen projection/)
    end
    
    specify 'default media is screen' do
      Jekyll::Jammit.configure do |c|
        c.environment = 'development'
        c.jammit_config = {
          'stylesheets' => { 'foo' => ['_site/stylesheets/file1.css', '_site/stylesheets/file2.css'] }
        }
      end
      rendered = render_template('{% include_css foo.css %}')
      rendered.should include_line_matching(/<link.*media=.*screen"/)
    end
  end
end
