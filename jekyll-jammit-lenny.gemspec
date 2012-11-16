# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jekyll-jammit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Lenny Marks"]
  gem.email         = ["lenny@aps.org"]
  gem.description   = %q{Jammit asset packaging integration for Jekyll}
  gem.summary       = %q{Jammit asset packaging integration for Jekyll}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jekyll-jammit-lenny"
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'jekyll'
  gem.add_dependency 'jammit'
  gem.version       = Jekyll::Jammit::VERSION
end
