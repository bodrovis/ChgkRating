module ChgkRating
  module Collections
    class Players < Base
      include ChgkRating::Concerns::Searching

      def initialize(params = {})
        super
      end

      private

      def process(_results, params = {})
        super { |result| ChgkRating::Models::Player.new result, lazy: params[:lazy] }
      end

      def api_path
        'players'
      end
    end
  end
end