module MenuGenerator
  class Submenu
    class << self
      attr_accessor :display_rule

      def use_display_rule(name)
        @display_rule = DisplayRule.find{|rule| rule.key == name}
      end
    end

    def initialize(name)
      @name = name
      @items = []
    end

    attr_reader :name, :items

    def item(name, opts={})
      @items << Item.new(opts.merge({:name => name, :submenu => self}))
      self
    end

    def use_display_rule(name)
      self.class.use_display_rule(name)
    end

    def display_rule
      self.class.display_rule
    end
  end
end

