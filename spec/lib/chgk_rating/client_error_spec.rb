RSpec.describe ChgkRating::Client do
  it 'should raise an error for an erroneous request' do
    expect( -> { VCR.use_cassette 'erroneous_request' do
      test_client.tournament '/thats/an/error'
    end } ).to raise_error(ChgkRating::Error::NotFound)
  end
end