require 'json'

class ParserGamesLogs
  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    @mode = 'r'
    file_exists()
  end
  

  def read_first_line()
    if file_exists
      File.open(@filename_with_path, @mode) do |log_file|
        log_file.readline
      end
    end
  end


  def parse_file()
    count = count_lines()
    output_hash = {@filename_with_path => { "lines" => count}}
    return output_hash.to_json
  end


  private
  
  def file_exists()
    raise Errno::ENOENT unless File.exist?(@filename_with_path)
    return true
  end


  def count_lines()
    if file_exists
      count = 0
      File.foreach(@filename_with_path) { count += 1 }
      return count
    end
  end
end
