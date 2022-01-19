require_relative "../parser.rb"

FILENAME_WITH_PATH = "games_logs_files/games.log"
FIRST_LINE = "  0:00 ------------------------------------------------------------\n"


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
end
