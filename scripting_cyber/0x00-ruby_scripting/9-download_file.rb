require 'open-uri'
require 'uri'
require 'fileutils'

if ARGV.length != 2
  puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
  exit
end

url = ARGV[0]
local_path = ARGV[1]

puts "Downloading file from #{url}..."

URI.open(url) do |file|
  File.open(local_path, 'wb') do |output|
    output.write(file.read)
  end
end

puts "File downloaded and saved to #{local_path}."
