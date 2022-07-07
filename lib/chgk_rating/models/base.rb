# frozen_string_literal: true

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

        extract_from raw_by(id)
        @lazy = false
        self
      end

      def self.no_eager_loading!
        define_method :eager_load! do |*_args|
          raise ChgkRating::Error::EagerLoadingNotSupported
        end
      end

      def self.no_lazy_support!
        const_set :NO_LAZY_SUPPORT, true
        undef_method :lazy
      end

      def to_h
        self.class.attribute_mapping.each_with_object({}) do |(attr, mapping), memo|
          data = send attr
          data = mapping[:transform_down].call(data) if mapping.key?(:transform_down)
          memo[mapping[:raw_name]] = data
        end
      end

      class << self
        # Grab the attribute mapping for the class and its superclass
        # (as superclass may present common mappings for multiple classes)
        def attribute_mapping
          return nil unless name

          ChgkRating::AttributeMappings.find(name).
            merge(ChgkRating::AttributeMappings.find(superclass.name))
        end
      end

      private

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

        get_result_by object
      end

      def get_result_by(object)
        result = get "#{api_path}/#{object}"
        result.is_a?(Array) ? result.first : result
      end

      def extract_from(raw_data)
        self.class.attribute_mapping.each do |attr, mapping|
          data = get_data_from raw_data, attr, mapping
          next unless data

          instance_variable_set "@#{attr}", transform_up(data, mapping)
        end
      end

      def get_data_from(raw, attr, mapping)
        raw.is_a?(self.class) ? raw.send(attr) : raw[mapping[:raw_name]]
      end

      def transform_up(data, mapping)
        return data unless mapping.key?(:transform_up)

        mapping[:transform_up].call(data)
      end
    end
  end
end
