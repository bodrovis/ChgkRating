module ChgkRating
  module Models
    class TournamentPlayer < Base
      no_eager_loading!
      no_lazy_support!
      attr_reader :id, :is_captain, :is_base, :is_foreign

      #def initialize(hash)
      def initialize(hash, _params = {})
        super
      end

      private

      def extract_from(data)
        @id = data['idplayer']
        @is_captain = to_boolean data['is_captain']
        @is_base = to_boolean data['is_base']
        @is_foreign = to_boolean data['is_foreign']
      end
    end
  end
end