# frozen_string_literal: true

require 'json'

class ParserGamesLogs
  IGNORED_PLAYER = '<world>'
  RE_PATTERN_PLAYERS = /(?:Kill:.*:) (.*) (?:killed) (.*) (?:by)|(?:ClientUserinfoChanged:.*n\\)(.*)(?:\\t\\0\\model.*)/
  RE_PATTERN_KILL = /(?:Kill:.*:) (.*) (?:killed) (.*) (?:by)/

  def initialize(filename_with_path)
    raise Errno::ENOENT unless File.exist?(filename_with_path)

    @filename_with_path = filename_with_path
  end

  def read_first_line
    File.open(@filename_with_path, &:readline)
  end

  def parse_file
    all_kills, total_kills = parse_kills
    { @filename_with_path => {
      'lines' => count_lines,
      'players' => parse_players,
      'kills' => all_kills,
      'total_kills' => total_kills
    } }.to_json
  end

  private

  def count_lines
    File.readlines(@filename_with_path).length
  end

  def parse_players
    File.readlines(@filename_with_path).flat_map do |line|
      next unless matches = line.match(RE_PATTERN_PLAYERS)

      matches.captures
    end.compact.uniq - [IGNORED_PLAYER]
  end

  def parse_kills
    players = parse_players
    initial_kills = Hash[players.map { |player| [player, 0] }]

    File.readlines(@filename_with_path).reduce([initial_kills, 0]) do |(kills, total), line|
      next [kills, total] unless matches = line.match(RE_PATTERN_KILL)

      killer, killed = matches.captures
      [kills.merge(counting_kill(killer, killed, kills)), total + 1]
    end
  end

  def counting_kill(killer, killed, kills)
    return { killed => kills[killed] - 1 } if killer == IGNORED_PLAYER

    { killer => kills[killer] + 1 }
  end
end
