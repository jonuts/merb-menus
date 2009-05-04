module Merb::Menus
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
      submenu.url_generator.rule.call(@submenu.name,@name)
    end

    def build_anchor
      submenu.display_style.rule.call(@name)
    end

  end
end

