# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','gloves-cli','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'gloves-cli'
  s.version = GlovesCli::VERSION
  s.author = 'Vlado Moravec'
  s.email = 'vladimir.moravec@gmail.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command line utility for Gloves'
  s.files = %w(
bin/gloves
lib/gloves-cli/version.rb
lib/gloves-cli.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','gloves-cli.rdoc']
  s.rdoc_options << '--title' << 'gloves-cli' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'gloves'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.0.0.rc3')
end
