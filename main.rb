require_relative "parser.rb"


def main()
  filename_with_path = "games_logs_files/games.log"
  begin
    parser = ParserGamesLogs.new(filename_with_path)
  rescue
    puts "Something went wrong."
  else
    print(parser.header_line) 
  end
end

main()
