GEM_NAME = "merb-menus"
GEM_VERSION = "0.0.1"
AUTHOR = "jonah honeyman"
EMAIL = "jonah@honeyman.org"
HOMEPAGE = "http://github.com/jonuts/merb-menus"
SUMMARY = "Merb plugin that provides dot dot dot"

Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION

  s.date = "2009-05-05"
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  #s.add_dependency('merb', '>= 1.0.11')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec}/**/*")
end
