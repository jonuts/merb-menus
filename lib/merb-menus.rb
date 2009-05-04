# make sure we're running inside Merb
if defined?(Merb::Plugins)
  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_menus] = {
    :chickens => false
  }

  Merb::BootLoader.before_app_loads do
    $:.push File.dirname(__FILE__)

    require 'merb-menus/menu_mixin'
    require 'merb-menus/rule'
    require 'merb-menus/menu'
    require 'merb-menus/submenu'
    require 'merb-menus/item'

  end

  Merb::BootLoader.after_app_loads do
  end

  Merb::Plugins.add_rakefiles "merb-menus/merbtasks"

  module Merb::Menus
    def self.[](menu)
      Menu[menu]
    end

    def self.default
      Menu.find{|menu| menu.default?} || Menu.first
    end
  end

  class Merb::Controller
    before do
      controller = params[:controller]
      action = params[:action]

      top = Merb::Menus.default
      return unless top

      menu = top.current_submenu = top.submenus.find{|e| e.name.to_s == controller}
      return unless menu

      item = menu.current_item = menu.items.find{|e| e.name.to_s == action}
    end

    def self.create_menu(name, &blk)
      Merb::Menus::Menu.new(name).instance_eval(&blk)
    end

    def self.use_menu(menu, submenu)
      top = Merb::Menus[menu]
      raise "Menu '#{menu}' does not exist" unless top

      top.current_submenu = top.submenus.find{|menu| menu.name == submenu}
      raise "Menu '#{menu}' does not exist" unless top.current_submenu
    end

    def menu_item(menu, submenu, item)
      self.class.use_menu(menu, submenu)
      top = Merb::Menus[menu]
      menu = top.submenus.find{|e| e.name == submenu}
      menu.current_item = menu.items.find{|e| e.name == item}
    end

    def current_menu_item
      if defined?(@@current_menu)
        action = params[:action]
        @@current_menu.items.find{|item| item.name.to_s == action}
      end
    end
  end
end

