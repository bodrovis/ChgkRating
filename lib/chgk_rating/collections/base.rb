module ChgkRating
  module Collections
    class Base
      include ChgkRating::Request
      include Enumerable

      attr_reader :items

      def each
        @items.each { |element| yield element }
      end

      def [](index)
        @items[index]
      end

      # Load data from API for all the resources of the collection if it was initially lazily loaded.
      # Set `force` to reload data even they are already present.
      def eager_load!(force = false)
        return unless @lazy || force
        @items.each(&:eager_load!)
        @lazy = false
      end
    end
  end
end