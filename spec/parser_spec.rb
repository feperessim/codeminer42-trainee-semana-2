# frozen_string_literal: true

require_relative '../parser'
require 'json'

describe ParserGamesLogs do
  let(:filename_with_path) { 'games_logs_files/games.log' }
  context 'When the file exists' do
    it 'Instantiates the class.' do
      expect { ParserGamesLogs.new(filename_with_path) }.not_to raise_error
    end

    let(:first_line) { "  0:00 ------------------------------------------------------------\n" }
    describe '#read_first_line' do
      it "Returns the first line of the file 'games.log'" do
        expect(ParserGamesLogs.new(filename_with_path).read_first_line).to eq(first_line)
      end
    end

    let(:total_number_of_lines) { 5306 }
    describe '#parse_file' do
      it 'Returns a json object after parses the file.' do
        json_parsed_file = JSON.parse(ParserGamesLogs.new(filename_with_path).parse_file)
        expect(json_parsed_file).to include(filename_with_path.to_s => { 'lines' => total_number_of_lines })
      end
    end
  end

  let(:wrong_filename_with_path) { 'wrong/path/games.log' }
  context 'When the file exists' do
    it 'Raises an Errno::ENOENT.' do
      expect { ParserGamesLogs.new(wrong_filename_with_path) }.to raise_error(Errno::ENOENT)
    end
  end
end
