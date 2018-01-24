module ChgkRating
  module Collections
    class Teams < Base
      include ChgkRating::Concerns::Searching

      private

      def process(_results, params = {})
        super { |result| ChgkRating::Models::Team.new result, lazy: params[:lazy] }
      end

      def api_path
        'teams'
      end
    end
  end
end