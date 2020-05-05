user = User.create(email: "matt@test.com", name: "Matt", password: "testtest")
user2 = User.create(email: "debbie@test.com", name: "Debbie", password: "testtest")
user3 = User.create(email: Faker::Internet.email, name: Faker::Name.name, password: "testtest")

User.all.each do |u|
  50.times do
    course = u.created_courses.create(name: Faker::Games::Zelda.location,
                                      city: Faker::Address.city,
                                      state: Faker::Address.state,
                                      style: %w[Links Desert Parkland].sample,
                                      access: %w[Public Semi-private Private Resort].sample)
    puts course
    # tee = course.tees.create(color: ["Black", "Blue", "White", "Gold", "Red"].sample)
    # puts tee
    # 18.times do |i|
    #   tee.holes.create(
    #     hole_number: i+1,
    #     par: Faker::Number.within(range: 3..5),
    #     yardage: Faker::Number.within(range: 150..550)
    #   )
    # end
    # tee.update(par: tee.holes.pluck(:par).sum, yardage: tee.holes.pluck(:yardage).sum)
  end
end

# User.all.each do |user|
#   20.times do
#     course = Course.all.sample
#     round = user.rounds.create(date: Faker::Date.between(from: 1.year.ago, to: Date.today), course: course) 
#     18.times do |i|
#       round.scorecards.create(hole_number: i+1, fairway: Faker::Number.within(range: 0..1), gir: Faker::Number.within(range: 0..1), putts: Faker::Number.within(range: 1..3), strokes: Faker::Number.within(range: 3..6))
#     end
#     puts round.scorecards.pluck(:strokes).sum
#   end
# end
