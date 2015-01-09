# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "AIzaSyCvHX8Wuiu5y8XjLiIw5QDoIITr7FHCza8")
User.create!(email: 'admin@probebe.com.br', role: 'admin', password: 'v1z12010').confirm!
