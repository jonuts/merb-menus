lib = File.expand_path("../lib", __FILE__)
$:.push(lib) unless $:.include?(lib)

require 'merb-menus/version'

Gem::Specification.new do |s|
  s.name = %q{merb-menus}
  s.version = Merb::Menus::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jonah honeyman"]
  s.date = %q{2011-01-19}
  s.description = %q{Merb plugin that provides dot dot dot uh menus}
  s.email = %q{jonah@honeyman.org}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = Dir.glob("lib/**/*") + ["LICENSE", "README", "Rakefile", "TODO"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jonuts/merb-menus}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Merb plugin that provides dot dot dot uh menus}
end

