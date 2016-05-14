# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a new person
person = Person.find_or_create_by(full_name: 'Ian Lloyd')
person.update(preferred_name: 'Ian', formal_greeting: 'Mr Lloyd')

# Create a new organization
org = Organization.find_or_create_by(name: 'Melanie Labs, Inc.')

# Link person to org as president
Role.create(from: person, to: org, title: 'President')


# Create some random people
people = 40.times.to_a.map do
  Person.create(full_name: Faker::Name.name)
end

# Create some random companies
orgs = 30.times.to_a.map do
  Organization.find_or_create_by(name: Faker::Company.name, ein: Faker::Company.ein, duns_number: Faker::Company.duns_number, logo_url: Faker::Company.logo).tap do |org|
    rand(0..7).times { Role.create(from: people.sample, to: org, title: Faker::Name.title) }
  end
end