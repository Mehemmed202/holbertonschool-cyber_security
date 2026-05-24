require 'json'
def count_user_ids(path)
  file_content=File.read(path)
  data=JSON.parse(file_content)
  id_num=hash.new(0)

  data.each do |row|
    user_id=row['userId']
    id_num[user_id] += 1 if user_id
  end

  id_num.each do |user_id, num|
    puts"#{user_id}: #{say}"
  end
end
