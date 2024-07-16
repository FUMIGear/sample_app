# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# Examples:
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# リスト 10.44:データベース上にサンプルユーザーを生成するRailsタスク
# リスト 11.4:サンプルユーザーを最初から有効にしておく
# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin:     true,
  activated: true, # リスト11.4
  activated_at: Time.zone.now) # リスト11.4

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      activated: true, # リスト11.4
      activated_at: Time.zone.now) # リスト11.4
  end
