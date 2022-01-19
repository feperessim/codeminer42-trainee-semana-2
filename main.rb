require_relative "parser.rb"


def main()
  filename_with_path = "games_logs_files/games.log"
  begin
    parser = ParserGamesLogs.new(filename_with_path)
  rescue
    puts "The class could not be instantiated because the file does not exist."
  else
    print(parser.read_first_line) 
  end
end


main()
