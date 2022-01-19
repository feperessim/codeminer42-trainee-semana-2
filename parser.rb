class ParserGamesLogs
  attr_accessor :header_line 

  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    @mode = 'r'
    @header_line = read_first_line()
    
    unless is_header_valid?()
      raise "Invalid file - The header does not match a valid pattern"
    end
  end
  
  private

  def read_first_line()
    File.open(@filename_with_path, @mode) do |log_file|
      log_file.readline
    end
  end

  
  def is_header_valid?()
    header_pattern = "0:00 ------------------------------------------------------------"
    return @header_line.strip == header_pattern
  end
end
