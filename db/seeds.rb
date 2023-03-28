#  Create a main sample user
User.create!(
    name: "tosh",
    email: "rinkanyadavid8@gmail.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
    activated: true,
    activated_at: Time.zone.now
)

User.create!(
    name: "grace",
    email: "grace@gmail.com",
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now
)

# generate a bunch of additional users

99.times do |n|
    User.create!(
        name: Faker::Name.name,
        email: "john.doe#{n + 1}@gmail.com",
        password: "password",
        password_confirmation: "password",
        activated: true,
        activated_at: Time.zone.now
    )
end

