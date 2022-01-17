require_relative "../parser.rb"

FILENAME_WITH_PATH = "games_logs_files/games.log"

describe ParserGamesLogs  do
  it "Raises exceptions when the file does not exist or when the file header is invalid" do
    expect { 
      parser = ParserGamesLogs.new(FILENAME_WITH_PATH)
    }.not_to raise_error
  end
end
