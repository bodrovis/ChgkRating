RSpec.describe ChgkRating::Collections::Teams do
  subject do
    VCR.use_cassette 'teams' do
      described_class.new
    end
  end
  let(:team) { subject[1] }

  it_behaves_like 'not a hash'
  it_behaves_like 'an array'

  specify('#id') { expect(team.id).to eq '2' }
  specify('#town') { expect(team.town).to eq 'Москва' }
  specify('#name') { expect(team.name).to eq 'Афина' }
  specify '#to_a' do
    teams_arr = subject.to_a
    expect(teams_arr.count).to eq 1000
    expect(teams_arr[3]['idteam']).to eq '5'
  end

  context 'pagination' do
    subject do
      VCR.use_cassette 'teams_page3' do
        described_class.new(page: 3)[1]
      end
    end

    specify('#id') { expect(subject.id).to eq '2285' }
    specify('#name') { expect(subject.name).to eq 'Эффект внезапности' }
  end

  context 'searching' do
    subject do
      VCR.use_cassette 'teams_searching' do
        described_class.search(request: {name: 'э', town: 'мин'})[0]
      end
    end

    specify('#id') { expect(subject.id).to eq '5444' }
    specify('#name') { expect(subject.name).to eq 'Эйфью' }
  end
end