# Sample data so the app has something to show: bin/rails db:seed
priya = User.find_or_create_by!(email_address: "priya@example.com") do |u|
  u.name = "Priya Sharma"
  u.password = "secret123"
end
asha = User.find_or_create_by!(email_address: "asha@example.com") do |u|
  u.name = "Asha Patil"
  u.password = "secret123"
end
meera = User.find_or_create_by!(email_address: "meera@example.com") do |u|
  u.name = "Meera Iyer"
  u.password = "secret123"
end

return if Item.exists?

bottle = priya.items.create!(title: "Blue water bottle", status: "lost", location: "Library, 2nd floor",
  happened_on: 2.days.ago, description: "Steel Milton bottle with a Rails Girls sticker on the side.")
asha.items.create!(title: "Student ID card", status: "found", location: "Canteen",
  happened_on: 1.day.ago, description: "Found near the tea counter. Message me with your roll number.")
meera.items.create!(title: "Black umbrella", status: "lost", location: "Main gate",
  happened_on: 3.days.ago, description: "Foldable, with a wooden handle.")
asha.items.create!(title: "Wireless earphones", status: "found", location: "Computer lab 3",
  happened_on: Date.current, description: "White case. Left on the desk near the window.")
priya.items.create!(title: "Bunch of keys", status: "found", location: "Basketball court",
  happened_on: 5.days.ago, resolved: true, description: "Three keys on a red keyring.")
meera.items.create!(title: "Physics notebook", status: "lost", location: "Lecture hall B",
  happened_on: 4.days.ago, description: "Green cover, name on the first page.")

bottle.comments.create!(user: meera, body: "I think I saw a blue bottle at the library front desk this morning!")
bottle.comments.create!(user: priya, body: "Thank you!! Going there now 🙏")
