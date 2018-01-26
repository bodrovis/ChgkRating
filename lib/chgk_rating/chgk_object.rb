module ChgkRating
  class ChgkObject
    def build_model(object, klass = ChgkRating::Models::Team, params = {lazy: true})
      return unless object
      object.instance_of?(klass) ? object : klass.new(object, params)
    end
  end
end