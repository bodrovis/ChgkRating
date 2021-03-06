module ChgkRating
  module Collections
    class Base < ChgkObject
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

      def to_a
        raise ChgkRating::Error::NotArrayType unless self.respond_to?(:to_a)
        self.items.to_a.map &:to_h
      end

      def to_h
        raise ChgkRating::Error::NotHashType unless self.respond_to?(:to_h)
        self.items.map { |k,v| revert_to_hash(k, v) }.to_h
      end

      def respond_to?(method, include_all = false)
        method = method.to_sym
        if %i( to_a to_h ).include?(method.to_sym)
          self.convertable? method
        else
          super
        end
      end

      def convertable?(method)
        return true if (method == :to_a && self.items.is_a?(Array)) ||
            (method == :to_h && self.items.is_a?(Hash))
        false
      end

      private

      def revert_to_hash(key, values)
        [key, values.to_h]
      end

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
        if results.is_a? Hash
          results.each { |season, result| results[season] = yield result }
        else
          results.map { |result| yield result }
        end
      end
    end
  end
end