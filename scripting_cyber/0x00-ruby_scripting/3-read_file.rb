require 'json'

def count_user_ids(path)
  # JSON faylını oxu
  data = JSON.parse(File.read(path))

  # userId saylarını saxlamaq üçün hash
  counts = Hash.new(0)

  # Hər element üçün userId-ni say
  data.each do |item|
    counts[item["userId"]] += 1
  end

  # Nəticəni çap et
  counts.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
end
