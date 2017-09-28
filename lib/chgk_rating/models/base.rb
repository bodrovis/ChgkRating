module ChgkRating
  module Models
    class Base
      include ChgkRating::Request
      include ChgkRating::Utils::BooleanParser

      def initialize(id_or_hash, params = {})
        raw = raw_by id_or_hash, lazy_load?(params)

        # If we only have an ID and `lazy` is set to true, then simply store this ID
        # Otherwise extract all data from the hash
        raw.nil? ? @id = id_or_hash : extract_from(raw)

        @lazy = params[:lazy] unless self.class.const_defined?(:NO_LAZY_SUPPORT)
      end

      # Load data from API if the resource was initially lazily loaded.
      # Set `force` to reload data even if it is already present.
      def eager_load!(force = false)
        return unless @lazy || force
        puts raw_by(self.id)
        extract_from raw_by(self.id)
        @lazy = false
      end

      def self.no_eager_loading!
        define_method :eager_load! do |*args|
          raise ChgkRating::Error::EagerLoadingNotSupported
        end
      end

      def self.no_lazy_support!
        self.const_set :NO_LAZY_SUPPORT, true
      end

      private

      def lazy_load?(params)
        @no_lazy_support ? false : params[:lazy]
      end

      def raw_by(object, lazy = false)
        # The `object` is either a hash or an ID.
        # If it is a hash - no need to load data via API, simply return this hash back
        # If it is an ID and `lazy` is set to `true` - do nothing,
        # we are going to only save this ID.
        return object if object.is_a?(Hash)
        return nil if lazy

        result = get("#{api_path}/#{object}")
        result.is_a?(Array) ? result.first : result
      end
    end
  end
end