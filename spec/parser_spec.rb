# frozen_string_literal: true

require_relative '../parser'
require 'json'

describe ParserGamesLogs do
  let(:filename_with_path) { 'spec/fixtures/test_file_games.log' }

  context 'When the file exists' do
    it 'Instantiates the class.' do
      expect { ParserGamesLogs.new(filename_with_path) }.not_to raise_error
    end

    describe '#read_first_line' do
      let(:first_line) { "  0:00 ------------------------------------------------------------\n" }

      it "Returns the first line of the file 'games.log'" do
        parser = ParserGamesLogs.new(filename_with_path)
        parser_first_line = parser.read_first_line
        expect(parser_first_line).to eq(first_line)
      end
    end

    describe '#parse_file' do
      let(:total_number_of_lines) { 33 }
      let(:players) do
        [
          'Isgalamido', 'Dono da Bola', 'Oootsimo', 'Assasinu Credi', 'Zeh', 'Mal'
        ]
      end
      let(:kills) do
        {
          'Isgalamido' => 1, 'Dono da Bola' => 5, 'Oootsimo' => 3, 'Assasinu Credi' => 1, 'Zeh' => 2, 'Mal' => 0
        }
      end
      let(:total_kills) { 16 }

      it 'Returns a json object after parses the file.' do
        parser = ParserGamesLogs.new(filename_with_path)
        json_parsed_file = JSON.parse(parser.parse_file)
        expect(json_parsed_file).to include(filename_with_path.to_s => {
          'lines' => 33,
          'players' => ['Isgalamido', 'Dono da Bola', 'Oootsimo', 'Assasinu Credi', 'Zeh', 'Mal'],
          'kills' => {'Isgalamido' => 1, 'Dono da Bola' => 5, 'Oootsimo' => 3, 'Assasinu Credi' => 1, 'Zeh' => 2, 'Mal' => 0},
          'total_kills' => 16 })
      end
    end
  end

  context 'When the file exists' do
    let(:wrong_filename_with_path) { 'wrong/path/games.log' }

    it 'Raises an Errno::ENOENT.' do
      expect { ParserGamesLogs.new(wrong_filename_with_path) }.to raise_error(Errno::ENOENT)
    end
  end
end
