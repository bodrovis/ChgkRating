module ChgkRating
  module Collections
    class Base
      include ChgkRating::Request
      include Enumerable

      attr_reader :items

      def initialize(params = {})
        results = if params[:collection].is_a?(Array)
                    params[:collection]
                  else
                    prepare get(api_path, respond_to?(:page_from) ? page_from(params) : {})
                  end
        @items = results.map { |result| process result, params }
      end

      def each
        @items.each { |element| yield element }
      end

      def [](index)
        @items[index]
      end

      private

      def prepare(raw_results)
        return raw_results if raw_results.is_a?(Array)
        return raw_results['tournaments'] if raw_results.has_key?('tournaments')
        return raw_results['items'] if raw_results.has_key?('items')
        return raw_results.values if raw_results.is_a?(Hash)
        raw_results
      end
    end
  end
end