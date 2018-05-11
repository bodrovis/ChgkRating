RSpec.describe ChgkRating::Collections::TournamentTeams do
  subject do
    VCR.use_cassette 'teams_at_tournament' do
      described_class.new(tournament: 3506)
    end
  end
  let(:team) { subject[0] }
  let(:tournament_team_h) { team.to_h }

  it_behaves_like 'not a hash'
  it_behaves_like 'an array'

  specify('#id') { expect(team.id).to eq '2124' }
  specify('#current_name') { expect(team.current_name).to eq 'Полосатый мамонт' }
  specify('#base_name') { expect(team.base_name).to eq 'Полосатый мамонт' }
  specify('#position') { expect(team.position).to eq 3 }
  specify('#questions_total') { expect(team.questions_total).to eq 34 }
  specify('#bonus_a') { expect(team.bonus_a).to eq 1575 }
  specify('#bonus_b') { expect(team.bonus_b).to eq -47 }
  specify('#tech_rating') { expect(team.tech_rating).to eq 2549 }
  specify('#predicted_position') { expect(team.predicted_position).to eq 2 }
  specify('#d_bonus_a') { expect(team.d_bonus_a).to eq 1575 }
  specify('#d_bonus_b') { expect(team.d_bonus_b).to eq 420 }
  specify('#d_diff_bonus') { expect(team.d_diff_bonus).to eq -47 }
  specify('#included_in_rating') { expect(team.included_in_rating).to eq true }
  specify('#result') { expect(team.result).to eq [true, true, true, false, true, true,
                                                     true, true, true, true, true,
                                                     true, true, false, false, false, false,
                                                     true, true, true, true, true, false, true,
                                                     true, true, false, false, true, false,
                                                     true, true, false, true, true, false, true,
                                                     false, true, false, true, true, true,
                                                     false, true, true, true, true] }

  specify '#to_a' do
    expect(subject.to_a[2]['idteam']).to eq '28434'
  end

  # to_h for a fully loaded model
  specify '#to_h for a model' do
    expect(tournament_team_h['idteam']).to eq '2124'
    expect(tournament_team_h['position']).to eq '3.0'
    expect(tournament_team_h['questions_total']).to eq '34'
    expect(tournament_team_h['mask']).to eq ["1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1",
                                             "1", "1", "0", "0", "0", "0", "1", "1", "1", "1", "1",
                                             "0", "1", "1", "1", "0", "0", "1", "0", "1", "1", "0",
                                             "1", "1", "0", "1", "0", "1", "0", "1", "1", "1", "0",
                                             "1", "1", "1", "1"]
    expect(tournament_team_h['bonus_a']).to eq '1575'
    expect(tournament_team_h['bonus_b']).to eq '-47'
    expect(tournament_team_h['tech_rating']).to eq '2549'
    expect(tournament_team_h['d_bonus_a']).to eq '1575'
    expect(tournament_team_h['d_bonus_b']).to eq '420'
    expect(tournament_team_h['d_diff_bonus']).to eq '-47'
    expect(tournament_team_h['predicted_position']).to eq '2'
    expect(tournament_team_h['included_in_rating']).to eq '1'
    expect(tournament_team_h['current_name']).to eq 'Полосатый мамонт'
    expect(tournament_team_h['base_name']).to eq 'Полосатый мамонт'
  end
end