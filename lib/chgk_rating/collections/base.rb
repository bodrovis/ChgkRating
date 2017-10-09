module ChgkRating
  module Collections
    class Base
      include ChgkRating::Request
      include Enumerable

      attr_reader :items

      def initialize(params = {})
        results = params[:collection] ||
            prepare(get(api_path, build_request_params_from(params)))

        @items = process results, params
      end

      def each
        @items.each { |item| yield(*item) }
      end

      def [](index)
        @items[index]
      end

      private

      def build_request_params_from(params)
        request_params = params[:request].to_h
        request_params[:page] = params.delete(:page).to_i if params.has_key?(:page)
        request_params
      end

      def prepare(raw_results)
        if raw_results.respond_to?(:has_key?)
          return raw_results['tournaments'] if raw_results.has_key?('tournaments')
          return raw_results['items'] if raw_results.has_key?('items')
        end

        raw_results
      end

      def process(results, *_args)
        if results.is_a? Array
          results.map { |result| yield result }
        else
          results.each { |season, result| results[season] = yield result }
        end
      end
    end
  end
end