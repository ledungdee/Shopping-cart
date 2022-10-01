# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



# Create a main sample user. 
# User.create!(name:"LE VAN DUNG", email:"admin@gmail.com", 
#             password:"123456", password_confirmation:"123456", admin:true)
 
# User.create!(name:"THE SECOND ADMIN", email:"admin2@gmail.com", 
#             password:"123456", password_confirmation:"123456", admin:true)

# User.create!(name:"User3", email:"user3@gmail.com", 
#             password:"123456", password_confirmation:"123456")
# User.create!(name:"User4", email:"user4@gmail.com", 
#             password:"123456", password_confirmation:"123456")


a = User.create!(name:"User6", email:"user6@gmail.com", 
            password:"123456", password_confirmation:"123456")

a.build_shop(name:"Shop user6",description:"Shop buon ban quan ao ")


#  Generate a bunch of additional users. 
# 99.times do |n| 
#     name = Faker::Name.name 
#     email = "example-#{n+1}@railstutorial.org" 
#     password = "password" 
#     User.create!(name: name, email: email, 
#                 password: password, password_confirmation: password) 
# end