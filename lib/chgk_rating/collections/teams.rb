module ChgkRating
  module Collections
    class Teams < Base
      include ChgkRating::Concerns::Searching
      include ChgkRating::Concerns::Pagination

      def initialize(params = {})
        super
      end

      private

      def process(result, params = {})
        ChgkRating::Models::Team.new result
      end

      def api_path
        'teams'
      end
    end
  end
end