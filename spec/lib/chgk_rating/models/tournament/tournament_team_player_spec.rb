# frozen_string_literal: true

RSpec.describe ChgkRating::Models::TournamentTeamPlayer do
  subject do
    VCR.use_cassette 'team_players_at_tournament' do
      test_client.team_players_at_tournament(3506, 52_853)[0]
    end
  end

  let(:tournament_player_h) { subject.to_h }

  it_behaves_like 'model without eager loading'
  it_behaves_like 'model without lazy support'
  it_behaves_like 'tournament team player' do
    let(:player) { subject }
  end

  specify '#to_h' do
    expect(tournament_player_h['idplayer']).to eq '51249'
    expect(tournament_player_h['is_captain']).to eq '1'
    expect(tournament_player_h['is_base']).to eq '1'
    expect(tournament_player_h['is_foreign']).to eq '0'
  end
end
