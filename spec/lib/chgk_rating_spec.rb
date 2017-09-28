RSpec.describe ChgkRating do
  specify '.client' do
    expect(ChgkRating.client).to be_an_instance_of(ChgkRating::Client)
  end
end