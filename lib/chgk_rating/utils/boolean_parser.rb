module ChgkRating
  module Utils
    module BooleanParser
      def to_boolean(arg)
        !arg.to_i.zero?
      end

      def to_binary_boolean(arg)
        arg ? '1' : '0'
      end
    end
  end
end