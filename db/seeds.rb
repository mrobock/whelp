User.create!([
  {
  first_name: "Chris",
  last_name: "Fasulo",
  email: "chris@Fasulo.com",
  username: "cfasulo",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Fariya",
  last_name: "Vasquez",
  email: "fariya@vasquez.com",
  username: "fvasquez",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Joshua",
  last_name: "Fishman",
  email: "josh@fishman.com",
  username: "jfishman",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Eric",
  last_name: "Hendrickson",
  email: "eric@hendrickson.com",
  username: "ehendrickson",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Varun",
  last_name: "Kapila",
  email: "varun@kapila.com",
  username: "vkapila",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Max",
  last_name: "Robock",
  email: "max@robock.com",
  username: "mrobock",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Mrinalini",
  last_name: "Sinha",
  email: "mrin@sinha.com",
  username: "msinha",
  password: "password",
  password_confirmation: "password"
  }])

user_1 = User.find_by(username: "cfasulo")
user_2 = User.find_by(username: "fvasquez")
user_3 = User.find_by(username: "jfishman")
user_4 = User.find_by(username: "ehendrickson")
user_5 = User.find_by(username: "vkapila")
user_6 = User.find_by(username: "mrobock")
user_7 = User.find_by(username: "msinha")

user_1.remove_role("default")
user_1.add_role("admin")
# user_2.add_role("default")
# user_3.add_role("default")
# user_4.add_role("default")
# user_5.add_role("default")
# user_6.add_role("default")
# user_7.add_role("default")

p "Added Main Users!"

user_names = [
  "Al Saunders", "Bobby Newport", "Caron Butler", "Denise Crosby", "Edward Olmos",
  "Fat Tuesday", "Garry Gergich", "Holly Flax", "Ilana Wexler", "Jessica Huang", "Karl Hevacheck",
  "Liz Lemon", "Mindy Lahiri", "Niecy Nash", "Otto Porter", "Penny Hartz", "Quendra WithAQ",
  "Rebecca Howe", "Sam Malone", "Terry Jeffords", "Uma Thurman", "Viola Davis", "Wil Wheaton", "Xanthipe Voorhees",
  "Yogi Bear", "Zlatan Ibrahimovic"
]

user_names.each do |user|
  user_split = user.split(" ")
  User.create!(
  first_name: user_split[0],
  last_name: user_split[1],
  email: "#{user_split[0][0].downcase + user_split[1].downcase}@yahoo.com",
  username: "#{user_split[0][0].downcase + user_split[1].downcase}",
  password: "password",
  password_confirmation: "password"
  )
end

p "Added Side Users!"

Venue.create!([
  {
  name: "LEARN",
  description: "Place in downtown",
  street_1: "704 J St",
  zip: "92101",
  user: user_1
  },{
  name: "OLD LEARN",
  description: "LIKE OLD GREGG BUT OLDER",
  street_1: "1550 Market St",
  zip: "92101",
  user: user_1
  },{
  name: "Thorn Brewery",
  description: "Located on Thorn Street!",
  street_1: "3176 Thorn St",
  zip: "92104",
  user: user_2
  },{
  name: "Alexander's",
  description: "Come through on Mondays!",
  street_1: "3391 30th St",
  zip: "92104",
  user: user_6
  },{
  name: "Thrusters Lounge",
  description: "Good times",
  street_1: "4633 Mission Blvd",
  zip: "92109",
  user: user_1
  },{
  name: "Montevalle",
  description: "Welcome to Salt Creek!",
  street_1: "840 Duncan Ranch Rd",
  zip: "91914",
  user: user_4
  },{
  name: "Rohr Park",
  description: "Run around in circles for hours and never get anywhere!",
  street_1: "4548 Sweetwater Rd",
  zip: "91902",
  user: user_5
  },{
  name: "Sunset Cliffs",
  description: "Natural cliffs overlooking the Pacific Ocean offer views of the coast & the occassional dog diver",
  street_1: "Ladera Street",
  zip: "92107",
  user: user_3
  },{
  name: "Mount Woodson Trail",
  description: "Fun area to hike with unusual rock formations & great views!",
  street_1: "Mount Woodson Trail",
  zip: "92064",
  user: user_2
  }
])

p "Added all Venues!"

venue_comments = [
  {text: "Try harder!", title: "Not the best"},
  {text: "Would be better off going something else", title: "Worst experience ever!"},
  {text: "Great, but comes at a price...", title: "Pricey"},
  {text: "I would come here over and over again!", title: "Let's go again!"},
  {text: "They remembered it was all about the dogs!", title: "Aw yea!"},
  {text: "Very comfortable place, love the open space!", title: "Cool"},
  {text: "Came well recommended! Did not disappoint!", title: "5 Starz!"},
  {text: "Didn't find what I was looking for. I guess I just need have high standards.", title: "Eh"},
  {text: "MUST VISIT THIS PLACE NOW", title: "BEST EVA!"},
  {text: "Don't be fooled by this comment, it is a place", title: "Secret!"},
  {text: "My dog enjoyed every second! Would recommend!", title: "Fun times!"},
  {text: "Been here many times, you should too!", title: "Come through!"},
  {text: "People need to pick up their shit", title: "Not great, Bob!"}
]

User.all.each do |user|
  (rand(2) + 1).times do |iter|
    v = Venue.order("RANDOM()").first
    index = rand(venue_comments.length)
    if (Rating.where(user: user, venue: v).length == 0)
      Rating.create!(user: user, venue: v, rating: rand(5) + 1)
      Comment.create!(user: user, venue: v, text: venue_comments[index][:text], title: venue_comments[index][:title])
    end
  end
end

p "Added Ratings/Comments to Venues!"

v = Venue.create!(
  name: "Hunter Industries",
  description: "Saving water one dog bowl at a time",
  street_1: "1890 Diamond St",
  zip: "92078",
  user: user_4
)

Rating.create!(user: user_4, venue: v, rating: 5)
Comment.create!(user: user_4, venue: v, text: "Mob dogging was fun!", title: "The power of the mob!")

past_events_to_create = [
  {
  name: "Dog Gone Good!",
  description: "The event is just that, good! Come out and join us wherever we are and have a good time!"
  },{
  name: "Where My Dawgs At?",
  description: "Come out and join us in playing hide and seek with other dogs!"
  },{
  name: "Doggie Dog World",
  description: "We had to change the title because of Michael Vick, but... Come and enter your dog into fun, competitive events! We have races, long jumps, and many more!"
  },{
  name: "Bark At The Bark",
  description: "Need more of the outdoors? Want help planet Earth? Come with your dogs as we plant trees!"
  },{
  name: "Unleash Yourself",
  description: "Need some time to unwind? Leave your dogs in our open space while you enjoy our mixer event!"
  },{
  name: "Snoopy Doo",
  description: "Snoopy. Scooby Doo. Your dog could be the next famous dog! Come out and showcase what your dog can do!"
  },{
  name: "Are We Having Fun Yet?!",
  description: "Seriously, drop by and tell us if we're having fun"
  }
]

past_events_to_create.each do |event|
  Event.create!(
    name: event[:name],
    date: DateTime.now - (rand(14) + 7) + (rand(24) / 24.0),
    description: event[:description],
    venue_id: Venue.order("RANDOM()").first.id,
    user_id: User.order("RANDOM()").first.id
  )
end

p "Added Past Events!"

comments = [
  "It was ok",
  "Would go again!",
  "First",
  "^ This",
  "My dog was super happy here!",
  "Lines were too long, but... I can't complain too much",
  "I stepped in dawg poop",
  "5 Stars!",
  "Friend recommended this event to me, did not enjoy it too much",
  "I mean, the guy with $11,000 suit, c'mon!",
  "Can any here help me with installing minecraft mods?",
  "3 Stars!",
  "Just wow! Better than anything I do at home!",
  "It is day 87 and the horses have accepted me as one of their own. I have grown to understand and respect their gentle ways. Now I question everything I thought I once knew and fear I am no longer capable of following through with my primary objective. I know that those who sent me will not relent. They will send others in my place… But we will be ready.",
  "Don't miss the next one!",
  "Meh",
  "If it wasn't for the other people, I would have enjoyed this.",
  "Thanks for everything!"
]
event_length = Event.where("date < ?", DateTime.now).length

User.all.each do |user|
  (rand(4) + 1).times do |iter|
    e = Event.where("date < ?", DateTime.now).order("RANDOM()").first
    if (Rsvp.where(user: user, event: e).length == 0)
      Rsvp.create!(user: user, event: e)
      Rating.create!(user: user, event: e, rating: rand(5) + 1)
      Comment.create!(user: user, event: e, text: comments[rand(comments.length)], title: "Title " + iter.to_s)
    end
  end
end

p "Added Users to Past Events!"

future_events_to_create = [
  {
  name: "Jurassic Bark",
  description: "Come out and explore all things Jurassic! We have bone pits, dress up stations, and more! Come meet old friends. We'd like to thank our main organizer, Philip J. Fry!"
  },{
  name: "Pleave Love Me",
  description: "Alone? Looking for a lifelong friend? Well... you may want to look elsewhere because we only have dogs for adoption! Come by to meet your partner in crime! (Side note: We really do mean meeting dogs, not other companions)"
  },{
  name: "Bark At The Park",
  descriptuon: "Come have a dog while you're with your dog at the park! All kinds of fun when you're at the park!"
  },{
  name: "Bark At Dark",
  description: "Who needs to see anything when you have your trusty companions nose! Come join us at dark and experience life through their nose!"
  },{
  name: "Treat Yo Self!",
  description: "Clothes! (Treat yo self). Doggy toys! (Treat yo self). Batman suit! (Treat yo self)."
  },{
  name: "Just Hang Out With Your Dog For Once",
  description: "I mean c'mon... Just this once."
  },{
  name: "What If Dog Was One Of Us",
  description: "There's nothing more to this event other than I was hoping to the sort of clever title would attract people."
  },{
  name: "Human Walk",
  description: "We flip it around and have the dogs walk you! I swear it's kinda fun... Sometimes."
  }
]

future_events_to_create.each do |event|
  Event.create!(
    name: event[:name],
    date: DateTime.now + (rand(14) + 7) + (rand(24) / 24.0),
    description: event[:description],
    venue_id: Venue.order("RANDOM()").first.id,
    user_id: User.order("RANDOM()").first.id
  )
end

p "Added Future Events!"

User.all.each do |user|
  (rand(2) + 1).times do |iter|
    e = Event.where("date >= ?", DateTime.now).order("RANDOM()").first
    if (Rsvp.where(user: user, event: e).length == 0)
      Rsvp.create!(user: user, event: e)
    end
  end
end

p "Added Users to Future Events!"

e = Event.create!(
  name: "Dogs Just Want To Have Fun",
  date: DateTime.now,
  description: "The title says it all.",
  venue_id: v.id,
  user_id: user_4.id
)

Rsvp.create!(user: user_4, event: e)
Rating.create!(user: user_4, event: e, rating: 5)
Comment.create!(user: user_4, event: e, text: "Not bad!", title: "!!!")
