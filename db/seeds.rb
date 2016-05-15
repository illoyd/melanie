# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a new person
person = Person.find_or_create_by!(full_name: 'Ian Lloyd', preferred_name: 'Ian')

# Create a new organization
org = Organization.find_or_create_by!(name: 'Melanie Labs, Inc.')

# Link person to org as president
Role.create!(from: person, to: org, title: 'President', created_by: person)
