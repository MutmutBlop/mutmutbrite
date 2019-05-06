# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email:'mutmutblop@yopmail.com', encrypted_password:'password', description:'I love pasta', first_name:'Mutmut', last_name:'Blop')

Event.create(user_id: User.last.id, title:'Best birthday ever', description:'Je fais ça pour avoir plein de cadeaux')
