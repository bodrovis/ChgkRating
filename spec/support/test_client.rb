module TestClient
  def test_client
    return if @client
    @client = ChgkRating.client
  end
end