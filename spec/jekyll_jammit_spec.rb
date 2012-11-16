require 'spec_helper'
require 'tmpdir'
require 'jekyll-jammit'

describe 'Jekyll Jammit' do
  let(:tmpdir) { Dir.mktmpdir }
  
  let(:jammit_config) do
    {
      'javascripts' => {
        'application' => ["#{tmpdir}/file1.js", "#{tmpdir}/file2.js"]
      },
      'stylesheets' => {
        'application' => ["#{tmpdir}/file1.css", "#{tmpdir}/file2.css"]
      }
    }
  end

  def write_file(name, content = '')
    File.open("#{tmpdir}/#{name}", 'w') { |f| f.write(content) }
  end
  
  def in_tmp_dir(&blk)
    FileUtils.cd(tmpdir, &blk)
  end
  
  before do
    write_file('assets.yml', jammit_config.to_yaml)
    write_file('file1.js', '//file1.js')
    write_file('file2.js', '//file2.js')
    write_file('file1.css', '/* file1.css */')
    write_file('file2.css', '/* file2.css */')
  end
  
  after do
    FileUtils.rm_rf(tmpdir)
  end
  
  def render_template(liquid)
    Liquid::Template.parse(liquid).render
  end
  
  describe 'include_js' do
    it 'includes javascript files individually in development' do
      in_tmp_dir do |d|
        Jekyll::Jammit.configure do |c|
          c.environment = 'development'
          c.jammit_config_path = 'assets.yml'
        end
        rendered = render_template('{% include_js application %}')
        rendered.should include_line_matching(/<script.*src=.*file1.js/)
        rendered.should include_line_matching(/<script.*src=.*file2.js/)
      end 
    end

    it 'includes concatenated javascripts in production' do
      in_tmp_dir do |d|
        Jekyll::Jammit.configure do |c|
          c.environment = 'production'
          c.jammit_config_path = 'assets.yml'
        end
        rendered = render_template('{% include_js application %}')
        rendered.should include_line_matching(/<script.*src=.*application.js/)
      end
    end
  end

  describe 'include_css' do
    it 'includes stylesheets individually in development' do
      in_tmp_dir do |d|
        Jekyll::Jammit.configure do |c|
          c.environment = 'development'
          c.jammit_config_path = 'assets.yml'
        end
        rendered = render_template('{% include_css application %}')
        rendered.should include_line_matching(/<link.*href=.*file2.css/)
        rendered.should include_line_matching(/<link.*href=.*file2.css/)
      end
    end

    it 'includes concatenated stylesheets in production' do
      in_tmp_dir do
        Jekyll::Jammit.configure do |c|
          c.environment = 'production'
          c.jammit_config_path = 'assets.yml'
        end
        rendered = render_template('{% include_css application %}')
        rendered.should include_line_matching(/<link href=.*application.css/)
      end
    end

    specify 'media attribute can be specified in tag' do
      in_tmp_dir do
        Jekyll::Jammit.configure do |c|
          c.environment = 'development'
          c.jammit_config_path = 'assets.yml'
        end
        rendered = render_template('{% include_css application screen projection %}')
        rendered.should include_line_matching(/<link.*media=.*screen projection/)
      end
    end

    specify 'default media is screen' do
      in_tmp_dir do
        Jekyll::Jammit.configure do |c|
          c.environment = 'development'
          c.jammit_config_path = 'assets.yml'
        end
        rendered = render_template('{% include_css application %}')
        rendered.should include_line_matching(/<link.*media=.*screen"/)
      end
    end
  end
end
