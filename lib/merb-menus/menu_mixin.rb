module Merb
  module MenuMixin
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def create_menu(name, &blk)
        Merb::Menus::Menu.new(name).instance_eval(&blk)
      end

      def use_menu(menu, submenu)
        top = Merb::Menus::Menu[menu] || raise("Menu '#{menu}' does not exist")
        @@current_menu = top.submenus.find{|menu| menu.name == submenu}
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

