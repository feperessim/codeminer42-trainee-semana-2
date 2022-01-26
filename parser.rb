# frozen_string_literal: true

require 'json'

#  Parser for quake3 games logs  file
class ParserGamesLogs
  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    raise Errno::ENOENT unless File.exist?(@filename_with_path)
  end

  def read_first_line
    File.open(@filename_with_path, &:readline)
  end

  def parse_file
    { @filename_with_path => { 'lines' => count_lines } }.to_json
  end

  private

  def count_lines
    File.readlines(@filename_with_path).length
  end
end
