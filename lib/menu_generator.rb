# make sure we're running inside Merb
if defined?(Merb::Plugins)
  require 'menu_generator/main_menu_mixin'
  require 'menu_generator/rule'
  require 'menu_generator/menu'
  require 'menu_generator/submenu'
  require 'menu_generator/item'

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:menu_generator] = {
    :chickens => false
  }

  Merb::BootLoader.before_app_loads do
    puts defined?(Application)
  end

  Merb::BootLoader.after_app_loads do
    Application.class_eval{include MenuGenerator::MainMenuMixin}
  end

  Merb::Plugins.add_rakefiles "menu_generator/merbtasks"

  module MenuGenerator;end
end
