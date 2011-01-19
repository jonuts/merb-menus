module Merb::Menus

  # This is the top level menu
  #
  # ==== Usage
  # Generate a menu in a controller:
  #
  #     create_menu :main_menu do
  #       # add some display styles
  #       display_style(:splitncap) {|thing| thing.to_s.split("_").map{|e| e.capitalize}.join(" ")}
  #       display_style(:dollarify) {|thing| "$#{thing.to_s.gsub(/_/,',')}"}
  #       default_display_style :splitncap
  #
  #       # define all of the submenus with their individual items
  #       submenu :videos do
  #         item :home, :url => '/videos'
  #         
  #         #this item will be generated with href '/videos/humor' and text 'Humor'
  #         item :humor
  #       end
  #
  #       submenu :audio do
  #         display_style :dollarify
  #         
  #         item :home, :href => '/audio'
  #         item :humor, :anchor => "LOL!!!"
  #       end
  #     end
  #         
  #
  class Menu
    extend Enumerable

    class << self
      attr_reader :collection

      def each
        @collection.each{|i| yield i}
      end

      def [](name)
        find{|e| e.name == name}
      end

      def first
        @collection.first
      end

      def reset!
        each do |e|
          e.submenus.each do |menu|
            menu.current_item = nil
            menu.items.clear
          end

          e.current_submenu = nil
        end
      end
    end

    @collection ||= []

    def initialize(name, is_default=false)
      @name       = name
      @is_default = is_default
      @submenus   = []
      create_default_rules
      use_display_style :default
      use_url_generator :default
      add_self_to_collection
    end

    attr_accessor :current_submenu, :default_display_style, :default_url_generator
    attr_reader :name, :submenus

    def submenu(name, opts={}, &data)
      submenu = Submenu.new(name, self, opts, &data)
      @submenus << submenu
      self
    end

    def display_style(key, &rule)
      DisplayStyle.add_rule(key, self, &rule)
    end

    def url_generator(key, &rule)
      UrlGenerator.add_rule(key, self, &rule)
    end

    def use_display_style(rule)
      self.default_display_style = DisplayStyle[rule]
    end

    def use_url_generator(rule)
      self.default_url_generator = UrlGenerator[rule]
    end
   
    def default?
      @is_default
    end

    def inspect
      "Merb::Menus::Menu - name~>#{self.name} - submenus~>[#{submenus.map{|e| e.name}.join(", ")}]"
    end

    def to_s
      name.to_s
    end

    private

    def add_self_to_collection
      Menu.collection << self unless Menu[name]
      self
    end

    def create_default_rules
      display_style(:default){|thing| thing.to_s}
      url_generator(:default){|menu, item| "/#{menu}/#{item}"}
    end

  end
end

