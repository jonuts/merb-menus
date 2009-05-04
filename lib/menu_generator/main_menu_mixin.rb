module MenuGenerator
  module MainMenuMixin
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def create_menu(name, &blk)
        MenuGenerator::Menu.new(name).instance_eval(&blk)
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

    def menu_item(*args)
      if args[2]
        self.class.use_menu(args[1], args[2])
      end
    end

  end
end

