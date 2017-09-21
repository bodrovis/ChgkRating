module ChgkRating
  module Models
    class Base
      include ChgkRating::Request

      def initialize(id_or_hash, lazy = false)
        raw = raw_by(id_or_hash, lazy)

        # If we only have an ID and `lazy` is set to true, then simply store this ID and set `lazy` attr to `true`
        # Otherwise extract all data from the hash
        if raw.nil?
          @id = id_or_hash
        else
          extract_from(raw)
        end
        @lazy = lazy
      end

      # Load data from API if the resource was initially lazily loaded.
      # Set `force` to reload data even they are already present.
      def eager_load!(force = false)
        return unless @lazy || force
        extract_from raw_by(self.id, api_path)
        @lazy = false
      end

      private

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