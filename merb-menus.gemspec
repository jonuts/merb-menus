# -*- encoding: utf-8 -*-

GEM_NAME = "merb-menus"
GEM_VERSION = '0.0.6'
AUTHOR = ["jonah honeyman"]
EMAIL = "jonah@honeyman.org"
HOMEPAGE = "http://github.com/jonuts/merb-menus"
SUMMARY = "Merb plugin that provides dot dot dot uh menus!"
FILES = %w(.rb /item.rb /menu.rb /merb_controller.rb /merbtasks.rb /rule.rb /submenu.rb /version.rb).map{|e| "lib/merb-menus#{e}"}

Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = AUTHOR
  s.date = "2009-05-06"
  s.description = SUMMARY
  s.email = EMAIL
  s.files = FILES + %w(LICENSE README Rakefile TODO)
  s.has_rdoc = true
  s.homepage = HOMEPAGE
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ['lib', 'lib/merb-menus']
  s.summary = SUMMARY
  #s.platform = Gem::Platform::RUBY
  #s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  #s.add_dependency('merb', '>= 1.0.11')
end
