module Merb::Menus
  class Submenu
    def initialize(name, menu, opts={}, &data)
      @name          = name
      @menu          = menu
      @display_style = @menu.default_display_style
      @url_generator = @menu.default_url_generator
      @details       = Item.new(opts.merge({:name => name, :submenu => self}))
      @items         = []
      @data          = data
    end

    attr_accessor :current_item
    attr_reader :name, :items, :menu, :display_style, :url_generator, :data

    def anchor
      @details.anchor
    end

    def href
      @details.href
    end

    def item(name, opts={})
      @items << Item.new(opts.merge({:name => name, :submenu => self})) unless
        @items.any? {|i| i.name == name}
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

    def generated!
      @generated = true
    end

    def generated?
      !!@generated
    end

    private

    # Don't generate the URLs until the action is hit
    # when using merb url/resource helpers
    def method_missing(meth, *args, &block)
      lambda {Merb::Menus.controller.send(meth, *args, &block)}
    end
  end
end

