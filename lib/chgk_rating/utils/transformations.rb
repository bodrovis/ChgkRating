module ChgkRating
  module Utils
    module Transformations
      # Default up transformation is integer
      # Default down transformation is string
      def transformation(name = 'integer_string')
        up, down = name.to_s.split '_'
        up = 'integer' if up.nil? || up.empty?
        down = 'string' if down.nil? || down.empty?

        %i(up down).inject({}) do |result, t|
          current_transformer = binding.local_variable_get t
          result.merge({
                           "transform_#{t}".to_sym => send(current_transformer)
                       })
        end
      end

      class << self
        def load_transformers!
          TRANSFORMERS.each do |method_name, transformer|
            define_method(method_name) { transformer }
          end
        end

        private

        def chgk_object(namespace, type = 'Models')
          ->(d) do
            opts = type == 'Models' ?
                       [d, {lazy: true}] :
                       [{collection: d, lazy: true}]

            Module.const_get("ChgkRating::#{type}::#{namespace}").new(*opts)
          end
        end

        def to_boolean
          ->(d) { !d.to_i.zero? }
        end

        def to_binary_boolean
          ->(d) { d ? '1' : '0' }
        end

        def to_star(method = :to_s, iterate = false)
          ->(d) do
            iterate ?
                d.map {|obj| obj.send method } :
                d.send(method)
          end
        end
      end

      TRANSFORMERS = {
          string: to_star,
          integer: to_star(:to_i),
          float: to_star(:to_f),
          id: to_star(:id),
          ids: to_star(:id, true),
          sym: to_star(:to_sym),
          strdate: to_star(:to_s_chgk),
          uri: ->(d) { URI.parse_safely d },
          boolean: to_boolean,
          binboolean: to_binary_boolean,
          date: ->(d) { Date.parse_safely d},
          datetime: ->(d) { DateTime.parse_safely d},
          splitboolean: ->(d) do
            d&.split('')&.map {|result| to_boolean.call(result)}
          end,
          arraystrboolean: ->(d) do
            d&.map {|result| to_binary_boolean.call(result)}
          end,
          arrayboolean: ->(d) do
            d&.map {|result| to_boolean.call(result)}
          end,
          team: chgk_object('Team'),
          player: chgk_object('Player'),
          players: chgk_object('Players', 'Collections')
      }.freeze

      load_transformers!
    end
  end
end