# make sure we're running inside Merb
if defined?(Merb::Plugins)
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

  module MenuGenerator
    class MainMenu
      class << self
        attr_reader :submenus, :display_rules, :url_generator

        def submenu(name, &blk)
          @submenus ||= []
          menu = Submenu.new(name)
          menu.instance_eval(&blk)
          @submenus << menu
          self
        end

        # If the menu key is a symbol that looks like this: :this_is_an_ugly_name,
        # make it look better by adding a rule like this:
        #   
        #   display_rule(:split_n_cap){ |thing| thing.to_s.split("_").map{|e| e.capitalize}.join(" ") }
        #
        # Then set this as the default rule in MainMenu or Submenu
        def display_rule(key, &style)
          @display_rules << DisplayRule.new(key, &style)
        end

        def default_url_generator(&style)
          @url_generator = style
        end
      end

      @display_rules ||= []

      default_url_generator{ |controller, action| "/#{controller}/#{action}"}
    end

    class DisplayRule
      def initialize(key, &rule)
        @key = key
        @rule = rule
      end

      attr_reader :key, :rule
    end

    class Submenu
      class << self
        attr_accessor :display_rule

        def use_display_rule(name)
          @display_rule = MainMenu.display_rules.find{|rule| rule.key == name}
          puts "@disply_rule = #{@display_rule.inspect}"
        end
      end

      def initialize(name)
        @name = name
        @items = []
      end

      attr_reader :name, :items

      def item(name, opts={})
        @items << Item.new(opts.merge({:name => name, :submenu => self}))
        self
      end

      def use_display_rule(name)
        self.class.use_display_rule(name)
      end

      def display_rule
        self.class.display_rule
      end
    end

    class Item
      def initialize(opts)
        @submenu = opts[:submenu]
        @name = opts[:name]
        @anchor = opts[:anchor] || build_anchor
        @href = opts[:href] || build_url
      end

      attr_reader :name, :anchor, :href, :submenu

      private

      def build_url
        MainMenu.url_generator.call(@submenu.name,@name)
      end

      def build_anchor
        submenu.display_rule.rule.call(@name)
      end

    end

    module MainMenuMixin
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def main_menu(&blk)
          @@menus = MenuGenerator::MainMenu.class_eval(&blk)
        end

        def use_menu(name)
          @@current_menu = @@menus.submenus.find{|menu| menu.name == name}
        end

        def menus
          @@menus
        end

        def current_menu
          @@current_menu
        end

      end
    end

  end
end
