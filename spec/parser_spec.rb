require_relative "../parser.rb"
require 'json'


FILENAME_WITH_PATH = "games_logs_files/games.log"
WRONG_FILENAME_WITH_PATH = "wrong/path/games.log"
FIRST_LINE = "  0:00 ------------------------------------------------------------\n"
TOTAL_NUMBER_OF_LINES = 5306


describe ParserGamesLogs do
  context "When the file exists" do
    it "Instantiates the class." do
      expect {ParserGamesLogs.new(FILENAME_WITH_PATH)}.not_to raise_error
    end

    describe '#read_first_line' do
      it "Checks whether the first line match with the one in the 'games.log' if the file exists" do
        expect {
          parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
          first_line = parser.read_first_line()
          expect(first_line).to eq(FIRST_LINE)          
        }.not_to raise_error
      end
    end

    describe '#parse_file' do
      it "Expects a json object with contents when parsing the file if it exists." do
        expect {
          parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
          json_parsed_file = JSON.parse(parser.parse_file())
          expect(json_parsed_file).to include( "#{FILENAME_WITH_PATH}" => {"lines"=> TOTAL_NUMBER_OF_LINES})
        }.not_to raise_error
      end
    end
  end

  context "When the file does not exist" do
    it "Raises an Errno::ENOENT" do
      expect {ParserGamesLogs.new(WRONG_FILENAME_WITH_PATH)}.to raise_error(Errno::ENOENT)
    end
  end
end
