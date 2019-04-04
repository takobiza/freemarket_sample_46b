# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "csv"

csv_data1 = CSV.read('db/category.csv', headers: true)

csv_data1.each do |data|
  Category.create!(data.to_hash)
end

Brand.create(name: "シャネル")
Brand.create(name: "ルイ ヴィトン")
Brand.create(name: "シュプリーム")
Brand.create(name: "ナイキ")
Brand.create(name: "シャンテクレール")
Brand.create(name: "シャペル")
Brand.create(name: "シナコバ")
Brand.create(name: "アシックス")
Brand.create(name: "エルルイ")
Brand.create(name: "リーム")
Brand.create(name: "シャルルガルニエ")

user = User.create!(email: "hoge@gmail.com", password: 11111111, nickname: "出品者")

UserDetail.create!(user_id: user.id, family_name: "山田", given_name: "光宙", family_name_kana: "ヤマダ", given_name_kana: "ピカチュウ", birth_year: 1996, birth_month: 03, birth_day: 10, cell_phone_number: "09011111111")

UserAddress.create!(user_id: user.id, family_name: "山崎", given_name: "大秘宝", family_name_kana: "ヤマザキ", given_name_kana: "ワンピース", postal_code: "150-0032", prefecture_id: 13, city: "渋谷区", block: "鶯谷町")

user = User.create!(email: "test@gmail.com", password: 11111111, nickname: "購入者")

UserDetail.create!(user_id: user.id, family_name: "佐藤", given_name: "光宙", family_name_kana: "サトウ", given_name_kana: "ピカチュウ", birth_year: 1996, birth_month: 03, birth_day: 10, cell_phone_number: "09011111111")

UserAddress.create!(user_id: user.id, family_name: "加藤", given_name: "大秘宝", family_name_kana: "カトウ", given_name_kana: "ワンピース", postal_code: "150-0032", prefecture_id: 13, city: "渋谷区", block: "鶯谷町")


