#  Create a main sample user
User.create!(
    name: "tosh",
    email: "rinkanyadavid8@gmail.com",
    password: "password",
    password_confirmation: "password",
    admin: true
)

User.create!(
    name: "grace",
    email: "grace@gmail.com",
    password: "password",
    password_confirmation: "password"
)

# generate a bunch of additional users

99.times do |n|
    User.create!(
        name: Faker::Name.name,
        email: "john.doe#{n + 1}@gmail.com",
        password: "password",
        password_confirmation: "password"
    )
end

