user = User.create(email: "matt@test.com", name: "Matt", password: "testing")
user2 = User.create(email: "debbie@test.com", name: "Debbie", password: "testing")
user3 = User.create(email: Faker::Internet.email, name: "#{Faker::Name.first_name} #{Faker::Name::last_name}", password: "testing")

# 20.times do
#   User.create(email: Faker::Internet.email, name: Faker::Name.name, password: "testtest")
# end

progress_count = 0

User.all.each do |u|
  20.times do
    course = u.created_courses.create(name: Faker::Games::Zelda.location,
                                      city: Faker::Address.city,
                                      state: Faker::Address.state,
                                      style: %w[Links Desert Parkland].sample,
                                      access: %w[Public Semi-private Private Resort].sample)
    progress_count += 1
    puts "Course Name: #{course.name} | #{progress_count.to_s}/60"
    %w[Black Blue White Gold Red].each do |color|
      tee = course.tees.create(color: color)
      puts "  #{tee.color} Tee"
      18.times do |i|
        tee.holes.create(
          hole_number: i+1,
          par: Faker::Number.within(range: 3..5),
          yardage: Faker::Number.within(range: 150..550)
        )
      end
    end
  end
end

User.all.each do |user|
  50.times do
    course = Course.all.sample
    round = user.rounds.create(date: Faker::Date.between(from: 1.year.ago, to: Date.today), course: course, tee: course.tees.sample.color) 
    18.times do |i|
      round.scorecards.create(hole_number: i+1, fairway: Faker::Number.within(range: 0..1), gir: Faker::Number.within(range: 0..1), putts: Faker::Number.within(range: 1..3), strokes: Faker::Number.within(range: 2..7))
    end
    puts course.name
    puts round.scorecards.pluck(:strokes).sum
  end
end
