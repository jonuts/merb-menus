module MainMenuMixin
  def self.included(base)
    base.extend ClassMethods
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
      @display_name = opts[:display] || @name.to_s.split_and_cap
      @uri = opts[:url] || build_url
    end

    attr_reader :name, :display_name, :uri, :submenu

    private

    def build_url
      "/#{@submenu}/#{@name}"
    end
  end

  module ClassMethods
    def main_menu(&blk)
      class_eval(&blk)
    end

    def submenu(name, &blk)
      @submenus << Submenu.new(name).instance_eval(&blk)
    end

    def use_menu(name)
      @current_menu = @submenus.find{|menu| menu.name == name}
    end
  end

end

