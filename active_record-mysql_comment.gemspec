# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record-mysql_comment/version'

Gem::Specification.new do |gem|
  gem.name          = "active_record-mysql_comment"
  gem.version       = ActiveRecord::MysqlComment::VERSION
  gem.authors       = ["holysugar"]
  gem.email         = ["holysugar@gmail.com"]
  gem.description   = %q{enable mysql comment column}
  gem.summary       = %q{enable mysql comment column}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'activerecord',  '>= 3.2.0' # XXX: but only checked in 3.2.9...
  gem.add_runtime_dependency 'activesupport', '>= 3.2.0'
  gem.add_runtime_dependency 'mysql2'

  gem.add_development_dependency 'rspec'
end
