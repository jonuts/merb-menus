module MenuGenerator
  class Rule
    extend Enumerable

    class << self
      attr_reader :collection

      def add_rule(key, &rule)
        return nil unless block_given? && unique?(key)
        @collection << new(key, &rule)
      end

      def each
        @collection.each{|i| yield i}
      end

      private

      def unique?(key)
        !find{|rule| rule.key == key}
      end
    end

    def initialize(key, &rule)
      @key = key
      @rule = rule
    end

    attr_reader :key, :rule
  end

  class UrlGenerator < Rule; @collection ||= []; end
  class DisplayRule  < Rule; @collection ||= []; end
end

