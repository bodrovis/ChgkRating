RSpec.shared_examples 'lazy loaded' do
  it 'is lazy loaded' do
    expect(object.lazy).to eq(true)
  end
end

RSpec.describe ChgkRating::Client do
  context 'errors' do
    it 'should raise an error for an erroneous request' do
      expect( -> { VCR.use_cassette 'erroneous_request' do
        test_client.tournament '/thats/an/error'
      end } ).to raise_error(ChgkRating::Error::NotFound)
    end
  end

  describe '#team_at_tournament' do
    subject { test_client.team_at_tournament 3506, 52853 }

    include_examples 'lazy loaded' do
      let(:object) { subject }
    end

    it 'should contain only lazily loaded data' do
      expect(subject.tournament_id).to eq(3506)
      expect(subject.id).to eq(52853)
    end
  end

  describe '#tournament' do
    let(:lazy_tournament) { test_client.tournament 3506, true }

    include_examples 'lazy loaded' do
      let(:object) { lazy_tournament }
    end

    it 'should support eager loading' do
      VCR.use_cassette 'tournament' do
        lazy_tournament.eager_load!
      end
      expect(lazy_tournament.name).to eq 'Чемпионат Перми и Пермского края'
    end

    it 'should request full info by default' do
      tournament = VCR.use_cassette 'tournament' do
        test_client.tournament 3506
      end

      expect(tournament).to be_an_instance_of ChgkRating::Models::Tournament
      expect(tournament.id).to eq '3506'
      expect(tournament.name).to eq 'Чемпионат Перми и Пермского края'
      expect(tournament.long_name).to eq 'XV Чемпионат Перми и Пермского края по игре "Что? Где? Когда?"'
      expect(tournament.date_start).to eq Date.parse('2015-11-08 14:00:00')
      expect(tournament.date_end).to eq Date.parse('2015-11-08 18:00:00')
      expect(tournament.tour_count).to eq 4
      expect(tournament.tour_questions).to eq 12
      expect(tournament.tour_ques_per_tour).to eq 0
      expect(tournament.questions_total).to eq 48
      expect(tournament.type_name).to eq 'Обычный'
      expect(tournament.main_payment_value).to eq 660
      expect(tournament.discounted_payment_value).to eq 360
      expect(tournament.discounted_payment_reason).to eq 'для детских команд; 480 - для студенческих'
      expect(tournament.date_requests_allowed_to).to be_nil
      expect(tournament.comment).to eq ''
      expect(tournament.site_url).to eq URI.parse('https://vk.com/chgk.perm.championship')
    end
  end

  describe '#rating' do
    it 'should return team rating for a given release' do
      team_rating = VCR.use_cassette 'rating_release' do
        test_client.team_rating 1, 24
      end

      expect(team_rating).to be_an_instance_of ChgkRating::Models::Rating
      expect(team_rating.team_id).to eq '1'
      expect(team_rating.rating).to eq 9071
      expect(team_rating.rating_position).to eq 9
      expect(team_rating.date.to_s).to eq '1999-01-07'
      expect(team_rating.formula).to eq :b
    end
  end

  describe '#recap' do
    it 'should allow to choose the last season' do
      recap = VCR.use_cassette 'recap_last_season' do
        test_client.recap 7931, :last
      end

      expect(recap).to be_an_instance_of ChgkRating::Models::Recap
      expect(recap.season_id).to eq '51'
      expect(recap.team_id).to eq '7931'
      expect(recap.captain.id).to eq '23539'
      expect(recap.players.first.id).to eq '2668'
    end

    it 'should allow to provide season number' do
      recap = VCR.use_cassette 'recap' do
        test_client.recap 1, 9
      end

      expect(recap.season_id).to eq '9'
      expect(recap.team_id).to eq '1'
      expect(recap.captain.id).to eq '2935'
      expect(recap.players.first.id).to eq '2935'
    end
  end

  specify '#team' do
    team = VCR.use_cassette 'team' do
      test_client.team(1)
    end

    expect(team).to be_an_instance_of ChgkRating::Models::Team
    expect(team.id).to eq '1'
    expect(team.town).to eq 'Москва'
    expect(team.name).to eq 'Неспроста'
  end

  specify '#player' do
    player = VCR.use_cassette 'player' do
      test_client.player(42511)
    end

    expect(player).to be_an_instance_of ChgkRating::Models::Player
    expect(player.id).to eq '42511'
    expect(player.surname).to eq 'Некрылов'
    expect(player.name).to eq 'Николай'
    expect(player.patronymic).to eq 'Андреевич'
    expect(player.db_chgk_info_tag).to eq 'nnekrylov'
  end
end