# frozen_string_literal: true

RSpec.describe ChgkRating::Collections::Players do
  subject do
    VCR.use_cassette 'players' do
      described_class.new
    end
  end

  let(:player) { subject[1] }

  it_behaves_like 'not a hash'
  it_behaves_like 'an array'

  specify '#to_a' do
    players_arr = subject.to_a
    expect(players_arr.count).to eq 1000
    expect(players_arr[10]['surname']).to eq 'Абарников'
  end

  specify('#id') { expect(player.id).to eq '6' }
  specify('#surname') { expect(player.surname).to eq 'Абаков' }
  specify('#name') { expect(player.name).to eq 'Карен' }

  it 'respond_to should still work properly' do
    expect(subject.respond_to?(:count)).to be true
  end

  context 'searching' do
    subject do
      VCR.use_cassette 'players_searching' do
        test_client.search_players(name: 'вас', surname: 'а')[28]
      end
    end

    specify('#id') { expect(subject.id).to eq '148380' }
    specify('#surname') { expect(subject.surname).to eq 'Абросимов' }
  end

  context 'pagination' do
    subject do
      VCR.use_cassette 'players_page3' do
        described_class.new(page: 3)[1]
      end
    end

    specify('#id') { expect(subject.id).to eq '2101' }
    specify('#surname') { expect(subject.surname).to eq 'Бажов' }
  end
end
