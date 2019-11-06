
# Create 40 Users with their own profiles
# Create 30 Locations
# Create 10 Crawls that have not passed yet
# Create 20 Crawls the have passed
# Make sure these crawls have between 1..3 locations from the 30 locations created
# Randomly assign these 30 crawls to the users (so that user may have multiple crawls)
# For each crawl, manually create between 0..10 attendees from the 40 users listed
# For each of the 20 past crawls, randomly create reviews between 0..crawl.attendees.length with random scores

##################
# Users/Profiles #
##################

for i in 1..40
  user = User.create(
    email: Faker::Internet.email,
    password: "password"
  )

  profile = Profile.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: Faker::Address.city,
    bio:  Faker::Lorem.sentence(word_count: 20, supplemental: true, random_words_to_add: 15),
    user_id: user.id
  )

  temp_profile_image = Down.download(Faker::LoremPixel.image + "?random=" + rand(1..1000).to_s)
  profile.profile_image.attach(io: temp_profile_image, filename: File.basename(temp_profile_image.path))
  puts "Profile image created!"

  profile.save

  puts "User/Profile #{i} created!"
end

users = User.all

#############
# Locations #
#############

for i in 1..90
  location = Location.new(
    title: Faker::Lorem.word.capitalize,
    location: Faker::Address.city,
    description: Faker::Lorem.sentence(word_count: 10, supplemental: true, random_words_to_add: 15)
  )

  temp_location_image = Down.download(Faker::LoremPixel.image + "?random=" + rand(1..1000).to_s)
  location.location_image.attach(io: temp_location_image, filename: File.basename(temp_location_image.path))
  puts "Location image created!"

  location.save

  puts "Created Location no. #{i}!"
end

locations = Location.all

###############
# Past crawls #
###############

locations_counter = 0

for i in 1..20
  crawl = Crawl.new(
    title: Faker::Book.title,
    location: Faker::Address.city,
    description: Faker::Lorem.sentence(word_count: 30, supplemental: true, random_words_to_add: 15),
    price: rand(1000..5000),
    finished: false,
    max_attendees: rand(10..20),
    crawl_date: Faker::Time.between(from: DateTime.now - 100, to: DateTime.now - 1),
    user_id: users.sample.id
  )
  
  for j in 1..3
    crawl.locations.push(locations[locations_counter])
    locations_counter += 1
  end

  temp_crawl_image = Down.download(Faker::LoremPixel.image + "?random=" + rand(1..1000).to_s)
  crawl.crawl_image.attach(io: temp_crawl_image, filename: File.basename(temp_crawl_image.path))
  puts "Crawl image created!"

  crawl.save

  pp crawl
  pp crawl.locations
  puts "Created Past Crawl no. #{i}!"
end

#################
# Future crawls #
#################

for i in 1..10
  crawl = Crawl.new(
    title: Faker::Book.title,
    location: Faker::Address.city,
    description: Faker::Lorem.sentence(word_count: 30, supplemental: true, random_words_to_add: 15),
    price: rand(1000..5000),
    finished: false,
    max_attendees: rand(10..20),
    crawl_date: Faker::Time.between(from: DateTime.now + 5, to: DateTime.now + 20),
    user_id: users.sample.id
  )
  
  for j in 1..3
    crawl.locations.push(locations[locations_counter])
    locations_counter += 1
  end

  temp_crawl_image = Down.download(Faker::LoremPixel.image + "?random=" + rand(1..1000).to_s)
  crawl.crawl_image.attach(io: temp_crawl_image, filename: File.basename(temp_crawl_image.path))
  puts "Crawl image created!"

  crawl.save

  pp crawl
  pp crawl.locations
  puts "Created Future Crawl no. #{i}!"
end

crawls = Crawl.all

#############
# Attendees #
#############

crawls.each do |crawl|
  user_sample = users.sample(rand(0..10))

  if user_sample.length > 0
    user_sample.each do |user|
      attendee = Attendee.new(
        user_id: user.id,
        crawl_id: crawl.id
      )
      crawl.attendees.push(attendee)
    end
  end

  puts "Crawl attendees: #{crawl.attendees}"
end

###########
# Reviews #
###########

past_crawls = Crawl.where("crawl_date < ?", Time.now)
puts past_crawls

past_crawls.each do |crawl|
  attendees_sample = crawl.attendees.sample(rand(0..crawl.attendees.length))

  attendees_sample.each do |attendee|
    review = Review.new(
      title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
      body: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 4),
      rating: (rand(0..5.0) * 2.0).round / 2.0,
      user_id: attendee.user_id
    )

    crawl.reviews.push(review)

    pp "Review for Crawl #{crawl.id} created!"
  end
end

