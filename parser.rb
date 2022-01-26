require 'json'


class ParserGamesLogs 
  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    raise Errno::ENOENT unless File.exist?(@filename_with_path)
  end
  

  def read_first_line
    File.open(@filename_with_path) do |log_file|
      log_file.readline
    end
  end


  def parse_file
    { @filename_with_path => {
        "lines" => count_lines,
        "players" => parse_players } }.to_json
  end
  
  
  private
  
  def count_lines
    File.readlines(@filename_with_path).length
  end


  def parse_players
    re_pattern_kill = /(?:Kill:.*:) (.*) (?:killed) (.*) (?:by)/
    re_pattern_client_user_info = /(?:ClientUserinfoChanged:.*n\\)(.*)(?:\\t\\0\\model.*)/
    players = []
    
    File.readlines(@filename_with_path).reduce([]) do |_, line|
      next unless matches = line.match(re_pattern_kill) || matches = line.match(re_pattern_client_user_info)
      matches.captures.each {|player| players.push(player) if player}
    end
    players.uniq
  end
end
