module MenuGenerator
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
end

