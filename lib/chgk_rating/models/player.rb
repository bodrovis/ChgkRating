module ChgkRating
  module Models
    class Player < Base
      attr_reader :id, :name, :surname, :patronymic, :comment, :db_chgk_info_tag

      #def initialize(id_or_hash, lazy = false)
      def initialize(id_or_hash, params = {})
        super
      end

      private

      def api_path
        'players'
      end

      def extract_from(data)
        @id = data['idplayer']
        @name = data['name']
        @surname = data['surname']
        @patronymic = data['patronymic']
        @comment = data['comment']
        @db_chgk_info_tag = data['db_chgk_info_tag']
      end
    end
  end
end