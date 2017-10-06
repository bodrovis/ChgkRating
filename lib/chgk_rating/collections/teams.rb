module ChgkRating
  module Collections
    class Teams < Base
      include ChgkRating::Concerns::Searching

      def initialize(params = {})
        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::Team.new result }
      end

      def api_path
        'teams'
      end
    end
  end
end