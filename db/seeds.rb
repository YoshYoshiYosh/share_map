# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'yoshikik@live.jp', password: 'Yoshiki1014', password_confirmation: 'Yoshiki1014')

def form_num(num)
  if num.to_s.length == 1
    '0' + num.to_s
  else
    num
  end
end

10.times do |n|
  no = form_num(n+1)
  User.create(
    email: "test#{no}@example.com",
    password: "Password-#{n}",
    password_confirmation: "Password-#{n}"
  )

end