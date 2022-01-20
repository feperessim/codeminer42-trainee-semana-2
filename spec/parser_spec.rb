require_relative "../parser.rb"
require 'json'

FILENAME_WITH_PATH = "games_logs_files/games.log"
FIRST_LINE = "  0:00 ------------------------------------------------------------\n"
TOTAL_NUMBER_OF_LINES = 5306


describe ParserGamesLogs do
  it "Raises exceptions when the file does not exist." do
    expect {parser = ParserGamesLogs.new(FILENAME_WITH_PATH)}.not_to raise_error
  end

  it "Checks whether the first line match with the one in the 'games.log' if the file exists" do
    expect {
      parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
      first_line = parser.read_first_line()
      expect(first_line).to eq(FIRST_LINE)          
    }.not_to raise_error
  end

    it "Counts the total number of lines into the file if it exists." do
    expect {
      parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
      count = parser.count_lines()
      expect(count).to eq(TOTAL_NUMBER_OF_LINES)
    }.not_to raise_error
  end

  it "Expects a json object with contents when parsing the file if it exists." do
    expect {
      parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
      json_parsed_file = JSON.parse(parser.parse_file())
      expect(json_parsed_file).to include( "#{FILENAME_WITH_PATH}" => {"lines"=>5306})
    }.not_to raise_error
  end
end
