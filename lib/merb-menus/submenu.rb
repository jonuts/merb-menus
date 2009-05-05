module Merb::Menus
  class Submenu
    def initialize(name, menu, opts={})
      @name          = name
      @menu          = menu
      @display_style = @menu.default_display_style
      @url_generator = @menu.default_url_generator
      @details       = Item.new(opts.merge({:name => name, :submenu => self}))
      @items         = []
    end

    attr_accessor :current_item
    attr_reader :name, :items, :menu, :display_style, :url_generator

    def anchor
      @details.anchor
    end

    def href
      @details.href
    end

    def item(name, opts={})
      @items << Item.new(opts.merge({:name => name, :submenu => self}))
      self
    end

    def use_display_style(name)
      @display_style = DisplayStyle[name]
    end

    def use_url_generator(name)
      @url_generator = UrlGenerator[name]
    end

    def inspect
      "Merb::Menus::Submenu - name~>#{name} - items~>[#{items.map{|e| e.name}.join(", ")}]"
    end

    def to_s
      anchor
    end
  end
end

