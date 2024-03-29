# frozen_string_literal: true

RSpec.describe ChgkRating::Models::Player do
  subject do
    VCR.use_cassette 'player' do
      described_class.new 42_511
    end
  end

  let(:player_h) { subject.to_h }
  let(:lazy_player) { described_class.new 42_511, lazy: true }

  it_behaves_like 'model with eager loading'
  it_behaves_like 'model with lazy support'

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

  specify '#eager_load!' do
    VCR.use_cassette 'player' do
      lazy_player.eager_load!
    end
    expect(lazy_player.name).to eq 'Николай'
  end

  describe '#rating' do
    let(:player_rating) do
      VCR.use_cassette 'player_rating_release' do
        subject.rating 1000
      end
    end

    it { expect(player_rating).to be_an_instance_of ChgkRating::Models::PlayerRating }
  end

  describe '#ratings' do
    let(:player_ratings) do
      VCR.use_cassette 'player_ratings_all_releases' do
        subject.ratings
      end
    end

    it { expect(player_ratings).to be_an_instance_of ChgkRating::Collections::PlayerRatings }
  end

  describe '#tournaments' do
    let(:player_tournaments) do
      VCR.use_cassette 'player_tournaments2' do
        subject.tournaments
      end
    end

    it { expect(player_tournaments).to be_an_instance_of ChgkRating::Collections::PlayerTournaments }
  end
end
