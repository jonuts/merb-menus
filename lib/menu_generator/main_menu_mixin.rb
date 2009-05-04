module MenuGenerator
  module MainMenuMixin
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def main_menu(name, &blk)
        @@menus = MenuGenerator::Menu.new(name).instance_eval(&blk)
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

