# frozen_string_literal: true

RSpec.describe String do
  describe '#snakecase_upcase' do
    let(:result) { 'SNAKE_CASE' }

    it 'converts the string properly' do
      expect('SnakeCase'.snakecase_upcase).to eq result
      expect('Snake-Case'.snakecase_upcase).to eq result
      expect('Snake Case'.snakecase_upcase).to eq result
      expect('Snake  -  Case'.snakecase_upcase).to eq result
    end
  end
end
