module ChgkRating
  module Models
    class TournamentTeamResult < Base
      no_eager_loading!
      no_lazy_support!

      attr_reader :tour, :result

      #def initialize(hash)
      def initialize(hash, _params = {})
        super
      end

      private

      def extract_from(data)
        @tour = data['tour']
        @result = data['mask'].map {|result| to_boolean(result) }
      end
    end
  end
end