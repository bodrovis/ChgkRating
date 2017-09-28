module ChgkRating
  module Concerns
    module Pagination
      def page_from(params)
        params[:page] ? {page: params[:page].to_i} : {}
      end
    end
  end
end