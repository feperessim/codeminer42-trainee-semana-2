class ParserGamesLogs
  def initialize(filename_with_path)
    @filename_with_path = filename_with_path
    @mode = 'r'
    file_exists?()
  end
  

  def read_first_line()
    if file_exists?
      File.open(@filename_with_path, @mode) do |log_file|
        log_file.readline
      end
    end
  end


  private
  
  def file_exists?()
    raise Errno::ENOENT unless File.exist?(@filename_with_path)
    return true
  end
end
