# frozen_string_literal: true

module TestClient
  def test_client
    return @client if @client

    @client = ChgkRating.client
  end
end
