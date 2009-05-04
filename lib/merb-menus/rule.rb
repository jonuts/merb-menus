module Merb::Menus
  class Rule
    extend Enumerable

    class << self
      attr_reader :collection

      def add_rule(key, owner, &rule)
        return nil unless block_given? and unique?(key, owner)
        @collection << new(key, &rule)
      end

      def each
        @collection.each{|i| yield i}
      end

      def [](key)
        find{|rule| rule.key == key}
      end

      private

      def unique?(key, owner)
        !find{|rule| rule.key == key && rule.owner == owner}
      end
    end

    def initialize(key, &rule)
      @key = key
      @rule = rule
    end

    attr_reader :key, :rule, :owner
  end

  class UrlGenerator < Rule; @collection ||= []; end
  class DisplayStyle  < Rule; @collection ||= []; end
end

