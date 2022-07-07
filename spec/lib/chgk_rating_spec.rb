# frozen_string_literal: true

RSpec.describe ChgkRating do
  specify '.client' do
    expect(described_class.client).to be_an_instance_of(ChgkRating::Client)
  end
end
