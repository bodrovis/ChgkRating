# frozen_string_literal: true

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
        raise ChgkRating::Error::NotArrayType unless respond_to?(:to_a)

        items.to_a.map(&:to_h)
      end

      def to_h
        raise ChgkRating::Error::NotHashType unless respond_to?(:to_h)

        items.to_h { |k, v| revert_to_hash(k, v) }
      end

      def respond_to?(method, include_all = false)
        method = method.to_sym
        if %i[to_a to_h].include?(method.to_sym)
          convertable? method
        else
          super
        end
      end

      def convertable?(method)
        return true if (method == :to_a && items.is_a?(Array)) ||
                       (method == :to_h && items.is_a?(Hash))

        false
      end

      private

      def revert_to_hash(key, values)
        [key, values.to_h]
      end

      def build_request_params_from(params)
        request_params = params[:request].to_h
        request_params[:page] = params.delete(:page).to_i if params.key?(:page)
        request_params
      end

      def prepare(raw_results)
        if raw_results.respond_to?(:has_key?)
          return raw_results['tournaments'] if raw_results.key?('tournaments')
          return raw_results['items'] if raw_results.key?('items')
        end

        raw_results
      end

      def process(results, *_args, &block)
        if results.is_a? Hash
          results.each { |season, result| results[season] = yield result }
        else
          results.map(&block)
        end
      end
    end
  end
end
