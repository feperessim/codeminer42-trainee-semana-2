# frozen_string_literal: true

require_relative '../parser'
require 'json'

describe ParserGamesLogs do
  let(:filename_with_path) { 'games_logs_files/games.log' }

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
      let(:total_number_of_lines) { 5306 }
      let(:players) do
        [
          'Isgalamido', 'Dono da Bola', 'Mocinha', 'Zeh', 'Assasinu Credi', 'Fasano Again',
          'Oootsimo', 'UnnamedPlayer', 'Maluquinho', 'Mal', 'Chessus!', 'Chessus'
        ]
      end
      let(:kills) do
        {
          'Isgalamido' => 147, 'Dono da Bola' => 63, 'Mocinha' => 0, 'Zeh' => 124, 'Assasinu Credi' => 111, 'Fasano Again' => 0,
          'Oootsimo' => 114, 'UnnamedPlayer' => 0, 'Maluquinho' => 0, 'Mal' => -3, 'Chessus!' => 0, 'Chessus' => 33
        }
      end
      let(:total_kills) { 1069 }

      it 'Returns a json object after parses the file.' do
        parser = ParserGamesLogs.new(filename_with_path)
        json_parsed_file = JSON.parse(parser.parse_file)
        expect(json_parsed_file).to include(filename_with_path.to_s => { 'lines' => total_number_of_lines,
                                                                         'players' => players, 'kills' => kills, 'total_kills' => total_kills })
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
