# frozen_string_literal: true

require 'json'

class ParserGamesLogs
  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    raise Errno::ENOENT unless File.exist?(@filename_with_path)
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
    re_pattern_players = /(?:Kill:.*:) (.*) (?:killed) (.*) (?:by)|(?:ClientUserinfoChanged:.*n\\)(.*)(?:\\t\\0\\model.*)/

    File.readlines(@filename_with_path).flat_map do |line|
      next unless matches = line.match(re_pattern_players)

      matches.captures
    end.compact.uniq - ['<world>']
  end
end
