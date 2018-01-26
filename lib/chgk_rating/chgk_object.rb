module ChgkRating
  class ChgkObject
    def build_model(object, klass = ChgkRating::Models::Team, params = {lazy: true})
      return unless object
      object.instance_of?(klass) ? object : klass.new(object, params)
    end

    def extract_id_from(obj, klass = ChgkRating::Models::Team)
      return obj unless obj.is_a? klass
      obj&.id
    end
  end
end