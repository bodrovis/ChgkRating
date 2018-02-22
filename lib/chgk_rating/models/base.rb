module ChgkRating
  module Models
    class Base < ChgkObject
      include ChgkRating::Request

      attr_reader :lazy

      def self.inherited(subclass)
        attr_reader(*subclass.attribute_mapping.keys) if subclass.attribute_mapping
        super
      end

      def initialize(id_or_hash, params = {})
        raw = raw_by id_or_hash, lazy_load?(params)

        # If we only have an ID and `lazy` is set to true, then simply store this ID
        # Otherwise extract all data from the hash
        raw.nil? ? @id = id_or_hash : extract_from(raw)

        @lazy = (params[:lazy] || false) unless self.class.const_defined?(:NO_LAZY_SUPPORT)
      end

      # Load data from API if the resource was initially lazily loaded.
      # Set `force` to reload data even if it is already present.
      def eager_load!(force = false)
        return unless @lazy || force
        extract_from raw_by(self.id)
        @lazy = false
        self
      end

      def self.no_eager_loading!
        define_method :eager_load! do |*_args|
          raise ChgkRating::Error::EagerLoadingNotSupported
        end
      end

      def self.no_lazy_support!
        self.const_set :NO_LAZY_SUPPORT, true
        undef_method :lazy
      end

      def to_h
        self.class.attribute_mapping.inject({}) do |memo, (attr, mapping)|
          data = self.send attr
          data = mapping[:transform_down].call(data) if mapping.has_key?(:transform_down)
          memo[ mapping[:raw_name] ] = data
          memo
        end
      end

      private

      def self.attribute_mapping
        return nil unless self.name
        ChgkRating::AttributeMappings.find self.name
      end

      def lazy_load?(params)
        self.class.const_defined?(:NO_LAZY_SUPPORT) ? false : params[:lazy]
      end

      # If the `object` is a `String` or `Integer` - that's an id.
      # If `lazy` is not set to `true` we need to perform an API request.
      # If `lazy` is set to `true` - do nothing,
      # we are going to only save this ID.
      # If the `object` is not a `String` or `Integer`, it already has all the necessary information and
      # so we simply create a new instance of the class using it.
      def raw_by(object, lazy = false)
        return object unless object.is_a?(String) || object.is_a?(Integer) || object.is_a?(Symbol)
        return nil if lazy

        result = get("#{api_path}/#{object}")
        result.is_a?(Array) ? result.first : result
      end

      def extract_from(raw_data)
        self.class.attribute_mapping.each do |attr, mapping|
          data = raw_data.is_a?(self.class) ? raw_data.send(attr) : raw_data[ mapping[:raw_name] ]
          data = mapping[:transform_up].call(data) if mapping.has_key?(:transform_up)
          instance_variable_set "@#{attr}", data
        end
      end
    end
  end
end