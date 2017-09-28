module ChgkRating
  module Collections
    class Players < Base
      include ChgkRating::Concerns::Searching
      include ChgkRating::Concerns::Pagination

      def initialize(params = {})
        super
      end

      private

      def process(result, params = {})
        ChgkRating::Models::Player.new result, lazy: params[:lazy]
      end

      def api_path
        'players'
      end
    end
  end
end