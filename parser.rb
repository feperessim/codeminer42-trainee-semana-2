# frozen_string_literal: true
require 'json'

class ParserGamesLogs
  IGNORED_PLAYER = '<world>'
  RE_PATTERN_PLAYERS = /(?:Kill:.*:) (.*) (?:killed) (.*) (?:by)|(?:ClientUserinfoChanged:.*n\\)(.*)(?:\\t\\0\\model.*)/

  def initialize(filename_with_path)
    raise Errno::ENOENT unless File.exist?(filename_with_path)

    @filename_with_path = filename_with_path
  end

  def read_first_line
    File.open(@filename_with_path, &:readline)
  end

  def parse_file
    { @filename_with_path => {
      'lines' => count_lines,
      'players' => parse_players
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
end
