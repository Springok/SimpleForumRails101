# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "生成一測試帳號"
puts "生成20個grou,每個group有30篇post"
create_account = User.create(email: "example@gmail.com",
                               password: "12345678",
                               password_confirmation: "12345678",
                               name: "麗子小姐"
                              )

20.times do |i|
    Group.create(title: "Group_" + Faker::Lorem.word, description: Faker::Lorem.sentences, user_id: "1")
    30.times do
      Post.create(group_id: "#{i+1}", context: Faker::Lorem.sentences, user_id: "1")
    end
end




