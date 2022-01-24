require_relative "../parser.rb"
require 'json'


FILENAME_WITH_PATH = "games_logs_files/games.log"
WRONG_FILENAME_WITH_PATH = "wrong/path/games.log"
FIRST_LINE = "  0:00 ------------------------------------------------------------\n"
TOTAL_NUMBER_OF_LINES = 5306


describe ParserGamesLogs do
  context "When attempt to create the object" do
    it "Instantiates the class if the file exists." do
      expect {ParserGamesLogs.new(FILENAME_WITH_PATH)}.not_to raise_error
    end
    
    it "Raises an Errno::ENOENT if the file does not exist" do
      expect {ParserGamesLogs.new(WRONG_FILENAME_WITH_PATH)}.to raise_error(Errno::ENOENT)
    end
  end
  
  describe '#read_first_line' do
    it "Returns the first line of the file 'games.log'" do
      parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
      first_line = parser.read_first_line()
      expect(first_line).to eq(FIRST_LINE)
    end
  end
  
  describe '#parse_file' do
    it "Returns a json object after parses the file." do
      parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
      json_parsed_file = JSON.parse(parser.parse_file())
      expect(json_parsed_file).to include( "#{FILENAME_WITH_PATH}" => {"lines"=> TOTAL_NUMBER_OF_LINES})
    end
  end
end


