# make sure we're running inside Merb
if defined?(Merb::Plugins)
  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_menus] = {
    :chickens => false
  }

  Merb::BootLoader.before_app_loads do
    $:.push File.dirname(__FILE__)

    require 'merb-menus/merb_controller'
    require 'merb-menus/rule'
    require 'merb-menus/menu'
    require 'merb-menus/submenu'
    require 'merb-menus/item'

  end

  Merb::BootLoader.after_app_loads do
  end

  Merb::Plugins.add_rakefiles "merb-menus/merbtasks"

  module Merb::Menus
    class << self; attr_accessor :current_menu; end

    class NoMenuError < StandardError;end

    def self.[](menu)
      Menu[menu]
    end

    def self.default
      Menu.find{|menu| menu.default?} || Menu.first
    end

    def self.reset
      Menu.reset
    end

    def self.current_submenu
      current_menu.current_submenu rescue nil
    end

    def self.current_item
      current_submenu.current_item rescue nil
    end
  end

end

