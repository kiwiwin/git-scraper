# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitscraper/version'

Gem::Specification.new do |gem|
  gem.name          = "gitscraper"
  gem.version       = Gitscraper::VERSION
  gem.authors       = ["kiwi"]
  gem.email         = ["kiwi.swhite.coder@gmail.com"]
  gem.description   = %q{scrape github}
  gem.summary       = %q{scrape github}
  gem.homepage      = "https://github.com/kiwiwin/git-scraper"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
