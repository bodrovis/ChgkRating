RSpec.describe ChgkRating::Collections::Teams do
  subject do
    VCR.use_cassette 'teams' do
      described_class.new[1]
    end
  end

  specify('#id') { expect(subject.id).to eq '2' }
  specify('#town') { expect(subject.town).to eq 'Москва' }
  specify('#name') { expect(subject.name).to eq 'Афина' }

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