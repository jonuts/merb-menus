module Merb::Menus
  class Item
    def initialize(opts, &data)
      @submenu    = opts.delete(:submenu)
      @name       = opts.delete(:name)
      @anchor     = opts.delete(:anchor) || build_anchor
      @href       = opts.delete(:href) || build_url
      @extra_opts = opts
    end

    attr_reader :name, :anchor, :submenu, :data, :extra_opts

    def inspect
      "<Merb::Menus::Item> - name~>#{name}"
    end

    def to_s
      anchor.to_s
    end

    def needs_generation?
      Proc === @href
    end

    def href
      needs_generation? ? @href[] : @href
    end

    private

    def build_url
      submenu.url_generator.rule.call(@submenu.name,@name)
    end

    def build_anchor
      submenu.display_style.rule.call(@name)
    end
  end
end

