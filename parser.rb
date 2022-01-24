require 'json'

class ParserGamesLogs
  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    @mode = 'r'
    raise Errno::ENOENT unless File.exist?(@filename_with_path)
  end
  

  def read_first_line
    File.open(@filename_with_path, @mode) do |log_file|
      log_file.readline
    end
  end


  def parse_file
    {@filename_with_path => { "lines" => count_lines()}}.to_json
  end
  
  
  private
  
  def count_lines
    File.open(@filename_with_path, @mode) do |log_file|
      log_file.readlines.length
    end
  end
end
