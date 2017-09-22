module ChgkRating
  module Utils
    module BooleanParser
      def to_boolean(arg)
        !arg.to_i.zero?
      end
    end
  end
end