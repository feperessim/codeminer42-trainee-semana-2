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
      'players' => players,
      'kills' => all_kills,
      'total_kills' => total_kills
    } }.to_json
  end

  private

  def count_lines
    file_read_lines.length
  end

  def players
    @players ||= file_read_lines.flat_map do |line|
      next [] unless matches = line.match(RE_PATTERN_PLAYERS)

      matches.captures.compact
    end.uniq - [IGNORED_PLAYER]
  end

  def parse_kills
    initial_kills = Hash[players.map { |player| [player, 0] }]

    file_read_lines.reduce([initial_kills, 0]) do |(kills, total), line|
      next [kills, total] unless matches = line.match(RE_PATTERN_KILL)

      [
        kills.merge(counting_kill(*matches.captures, kills)),
        total + 1
      ]
    end
  end

  def counting_kill(killer, killed, kills)
    return { killed => kills[killed] - 1 } if killer == IGNORED_PLAYER

    { killer => kills[killer] + 1 }
  end

  def file_read_lines
    @file_read_lines ||= File.readlines(@filename_with_path)
  end
end
