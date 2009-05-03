# make sure we're running inside Merb
if defined?(Merb::Plugins)
  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:menu_generator] = {
    :chickens => false
  }

  Merb::BootLoader.before_app_loads do
    Application.class_eval{class << self; attr_reader :main_menu, :current_menu; end}
  end

  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end

  Merb::Plugins.add_rakefiles "menu_generator/merbtasks"

  module MenuGenerator
    class MainMenu
      class << self
        attr_reader :submenus, :display_rules

        def submenu(name, &blk)
          @submenus ||= []
          @submenus << Submenu.new(name).instance_eval(&blk)
        end

        # If the menu key is a symbol that looks like this: :this_is_an_ugly_name,
        # make it look better by adding a rule like this:
        #   
        #   display_rule :split_n_cap, lambda{|thing| thing.to_s.split("_").map{|e| e.capitalize}.join(" ")}
        #
        # Then set this as the default rule in MainMenu or Submenu
        def display_rule(key, style)
          @display_rules << DisplayRule.new(key, style)
        end
      end
    end

    class Submenu
      def initialize(name)
        @name = name
        @items = []
      end

      attr_reader :name, :items

      def item(name, opts={})
        @items << Item.new(opts.merge({:name => name, :submenu => self.name}))
        self
      end
    end

    class Item
      def initialize(opts)
        @submenu = opts[:submenu]
        @name = opts[:name]
        @display_name = opts[:display] || @name
        @uri = opts[:url] || build_url
      end

      attr_reader :name, :display_name, :uri, :submenu

      private

      def build_url
        "/#{@submenu}/#{@name}"
      end
    end

    module MainMenuMixin
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def main_menu(&blk)
          @main_menu = MenuGenerator::MainMenu.new.instance_eval(&blk)
        end

        def use_menu(name)
          @current_menu = main_menu.submenus.find{|menu| menu.name == name}
        end

      end
    end

  end
end
