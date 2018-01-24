RSpec.describe ChgkRating::Models::Player do
  subject do
    VCR.use_cassette 'player' do
      described_class.new 42511
    end
  end
  let(:player_h) { subject.to_h }

  specify('#id') { expect(subject.id).to eq '42511' }
  specify('#surname') { expect(subject.surname).to eq 'Некрылов' }
  specify('#name') { expect(subject.name).to eq 'Николай' }
  specify('#patronymic') { expect(subject.patronymic).to eq 'Андреевич' }
  specify('#db_chgk_info_tag') { expect(subject.db_chgk_info_tag).to eq 'nnekrylov' }
  specify('#comment') { expect(subject.comment).to eq '' }

  specify '#to_h' do
    expect(player_h['idplayer']).to eq '42511'
    expect(player_h['name']).to eq 'Николай'
    expect(player_h['surname']).to eq 'Некрылов'
    expect(player_h['patronymic']).to eq 'Андреевич'
    expect(player_h['comment']).to eq ''
    expect(player_h['db_chgk_info_tag']).to eq 'nnekrylov'
  end
end