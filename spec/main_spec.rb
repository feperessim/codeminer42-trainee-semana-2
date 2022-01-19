require_relative "../main.rb"

HEADER_PATTERN = "  0:00 ------------------------------------------------------------\n"

describe 'main.rb' do
  it "Prints the first line of the file games.logs" do
    expect { main }.to output(HEADER_PATTERN).to_stdout
  end
end
