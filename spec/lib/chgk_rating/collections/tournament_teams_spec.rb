RSpec.describe ChgkRating::Collections::TournamentTeams do
  subject do
    VCR.use_cassette 'teams_at_tournament' do
      described_class.new(tournament_id: 3506)[0]
    end
  end
  let(:tournament_team_h) { subject.to_h }

  specify('#id') { expect(subject.id).to eq '2124' }
  specify('#current_name') { expect(subject.current_name).to eq 'Полосатый мамонт' }
  specify('#base_name') { expect(subject.base_name).to eq 'Полосатый мамонт' }
  specify('#position') { expect(subject.position).to eq 3 }
  specify('#questions_total') { expect(subject.questions_total).to eq 34 }
  specify('#bonus_a') { expect(subject.bonus_a).to eq 1575 }
  specify('#bonus_b') { expect(subject.bonus_b).to eq -48 }
  specify('#tech_rating') { expect(subject.tech_rating).to eq 2561 }
  specify('#predicted_position') { expect(subject.predicted_position).to eq 2 }
  specify('#real_bonus_b') { expect(subject.real_bonus_b).to eq 421 }
  specify('#d_bonus_b') { expect(subject.d_bonus_b).to eq -48 }
  specify('#included_in_rating') { expect(subject.included_in_rating).to eq true }
  specify('#result') { expect(subject.result).to eq [true, true, true, false, true, true,
                                                     true, true, true, true, true,
                                                     true, true, false, false, false, false,
                                                     true, true, true, true, true, false, true,
                                                     true, true, false, false, true, false,
                                                     true, true, false, true, true, false, true,
                                                     false, true, false, true, true, true,
                                                     false, true, true, true, true] }

  # to_h for a fully loaded model
  specify '#to_h' do
    expect(tournament_team_h['idteam']).to eq '2124'
    expect(tournament_team_h['position']).to eq '3.0'
    expect(tournament_team_h['questions_total']).to eq '34'
    expect(tournament_team_h['mask']).to eq ["1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1",
                                             "1", "1", "0", "0", "0", "0", "1", "1", "1", "1", "1",
                                             "0", "1", "1", "1", "0", "0", "1", "0", "1", "1", "0",
                                             "1", "1", "0", "1", "0", "1", "0", "1", "1", "1", "0",
                                             "1", "1", "1", "1"]
    expect(tournament_team_h['bonus_a']).to eq '1575'
    expect(tournament_team_h['bonus_b']).to eq '-48'
    expect(tournament_team_h['tech_rating']).to eq '2561'
    expect(tournament_team_h['real_bonus_b']).to eq '421'
    expect(tournament_team_h['real_bonus_b']).to eq '421'
    expect(tournament_team_h['d_bonus_b']).to eq '-48'
    expect(tournament_team_h['included_in_rating']).to eq '1'
    expect(tournament_team_h['current_name']).to eq 'Полосатый мамонт'
    expect(tournament_team_h['base_name']).to eq 'Полосатый мамонт'
  end
end