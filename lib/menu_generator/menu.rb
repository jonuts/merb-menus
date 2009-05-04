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
        @display_rules << DisplayRule.add_rule(key, &style)
      end

      def default_url_generator(&style)
        @url_generator = style
      end
    end

    @display_rules ||= []

    default_url_generator{ |controller, action| "/#{controller}/#{action}"}
  end
end

