# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb-menus}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jonah honeyman"]
  s.date = %q{2009-05-06}
  s.description = %q{Merb plugin that provides dot dot dot uh menus}
  s.email = %q{jonah@honeyman.org}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb-menus", "lib/merb-menus/item.rb", "lib/merb-menus/menu.rb", "lib/merb-menus/merb_controller.rb", "lib/merb-menus/merbtasks.rb", "lib/merb-menus/rule.rb", "lib/merb-menus/submenu.rb", "lib/merb-menus/version.rb", "lib/merb-menus.rb", "spec/merb-menus", "spec/merb-menus/item_spec.rb", "spec/merb-menus/menu_spec.rb", "spec/merb-menus/rule.rb", "spec/merb-menus/submenu_spec.rb", "spec/merb-menus_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jonuts/merb-menus}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb plugin that provides dot dot dot uh menus}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
