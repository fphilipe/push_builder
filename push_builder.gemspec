lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'push_builder/version'

Gem::Specification.new do |gem|
  gem.name          = 'push_builder'
  gem.version       = PushBuilder::VERSION
  gem.authors       = ['Philipe Fatio']
  gem.email         = ['me@phili.pe']
  gem.summary       = %q{Easily construct JSON payloads for Apple's push notification service.}
  gem.description   = gem.summary
  gem.homepage      = 'https://github.com/fphilipe/push_builder'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_development_dependency 'rspec', '~> 2.12'

  gem.add_dependency 'multi_json', '~> 1.0'
end
