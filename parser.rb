require 'json'


class ParserGamesLogs 
  def initialize(filename_with_path)
    raise Errno::ENOENT unless File.exist?(filename_with_path)
    @filename_with_path = filename_with_path
  end
  

  def read_first_line
    File.open(@filename_with_path) do |log_file|
      log_file.readline
    end
  end


  def parse_file
    all_kills, total_kills = parse_kills
    { @filename_with_path => {
        "lines" => count_lines,
        "players" => parse_players,
        "kills" => all_kills,
        "total_kills" => total_kills } }.to_json
  end
  
  
  private
  
  def count_lines
    File.readlines(@filename_with_path).length
  end


  def parse_players
    re_pattern_kill = /(?:Kill:.*:)(.*)(?:killed)(.*)(?:by)/
    re_pattern_client_user_info = /(?:ClientUserinfoChanged:.*n\\)(.*)(?:\\t\\0\\model.*)/
    players = []
    
    File.foreach(@filename_with_path) { |line|
      if line.match(re_pattern_kill) { |m|
           m.captures.each {|player|
             players.push(player.strip) if player
           }
         }
      elsif line.match(re_pattern_client_user_info) { |m|
              m.captures.each {|player|
                players.push(player.strip) if player
              }
            }
      end
    }
    players.uniq
  end

  
  def parse_kills
    re_pattern_kill = /(?:Kill:.*:) (.*) (?:killed) (.*) (?:by)/
    players = parse_players - ['<world>']
    initial_kills = players.each_with_object(Hash.new(0)){ |key, hash| hash[key] = 0}
    File.readlines(@filename_with_path).reduce([initial_kills, 0]) do |(kills, total), line|
      next [kills, total] unless matches = line.match(re_pattern_kill)
      killer, killed = matches.captures
      [kills.merge(counting_kill(killer, killed, kills)), total + 1]
    end
  end
  

  def counting_kill(killer, killed, kills)
    return { killed => kills[killed] - 1 } if killer == "<world>"
    { killer => kills[killer] + 1 }
  end
end
