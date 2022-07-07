# frozen_string_literal: true

module ChgkRating
  module Utils
    module Transformations
      def transformation(name = 'integer_string')
        up, down = name.to_s.split '_'
        up = 'integer' if up.nil? || up.empty?
        down = 'string' if down.nil? || down.empty?

        %i[up down].reduce({}) do |result, t|
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
          lambda do |d|
            opts = if type == 'Models'
                     [d, {lazy: true}]
                   else
                     [{collection: d, lazy: true}]
                   end

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
          lambda do |d|
            if iterate
              d.map { |obj| obj.send method }
            else
              d.send(method)
            end
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
        date: ->(d) { Date.parse_safely d },
        datetime: ->(d) { DateTime.parse_safely d },
        splitboolean: lambda do |d|
                        d&.split('')&.map { |result| to_boolean.call(result) }
                      end,
        arraystrboolean: lambda do |d|
                           d&.map { |result| to_binary_boolean.call(result) }
                         end,
        arrayboolean: lambda do |d|
                        d&.map { |result| to_boolean.call(result) }
                      end,
        team: chgk_object('Team'),
        tournament: chgk_object('Tournament'),
        player: chgk_object('Player'),
        players: chgk_object('Players', 'Collections')
      }.freeze

      load_transformers!
    end
  end
end
