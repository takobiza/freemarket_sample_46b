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

user = User.create!(email: "hoge@gmail.com", password: 11111111, nickname: "メルカリ太郎")

UserDetail.create!(user_id: user.id, family_name: "山田", given_name: "光宙", family_name_kana: "ヤマダ", given_name_kana: "ピカチュウ", birth_year: 1996, birth_month: 03, birth_day: 10, cell_phone_number: "09011111111")

UserAddress.create!(user_id: user.id, family_name: "山崎", given_name: "大秘宝", family_name_kana: "ヤマザキ", given_name_kana: "ワンピース", postal_code: "150-0032", prefecture_id: 13, city: "渋谷区", block: "鶯谷町")

Product.create(name: "シャネル 長財布",price: 18999, state_id: 1, is_buy: true, status: true, category_id: 276, brand_id: 1, user_id: user.id)
Product.create(name: "シャネル ジャケット",price: 10000, state_id: 2, is_buy: true, status: true, category_id: 177, brand_id: 1, user_id: user.id)
Product.create(name: "シャネル 香水",price: 1000, state_id: 3, is_buy: true, status: true, category_id: 876, brand_id: 1, user_id: user.id)
Product.create(name: "シャネル 靴",price: 1000, state_id: 3, is_buy: true, status: true, category_id: 219, brand_id: 1, user_id: user.id)

Product.create(name: "ルイ ヴィトン 長財布",price: 18999, state_id: 1, is_buy: true, status: true, category_id: 276, brand_id: 2, user_id: user.id)
Product.create(name: "ルイ ヴィトン バッグ",price: 18999, state_id: 1, is_buy: true, status: true, category_id: 244, brand_id: 2, user_id: user.id)
Product.create(name: "ルイ ヴィトン 靴",price: 18999, state_id: 1, is_buy: true, status: true, category_id: 219, brand_id: 2, user_id: user.id)
Product.create(name: "ルイ ヴィトン デニム",price: 18999, state_id: 1, is_buy: true, size: 1, status: true, category_id: 198, brand_id: 2, user_id: user.id)

Product.create(name: "シュプリーム Tシャツ",price: 18999, state_id: 1, is_buy: true, size: 1,status: true, category_id: 337, brand_id: 3, user_id: user.id)
Product.create(name: "シュプリーム 靴",price: 10000, state_id: 2, is_buy: true, status: true, size: 1,category_id: 380, brand_id: 3, user_id: user.id)
Product.create(name: "シュプリーム バッグ",price: 1000, state_id: 3, is_buy: true, status: true, category_id: 388, brand_id: 3, user_id: user.id)
Product.create(name: "シュプリーム ジャケット",price: 1000, state_id: 3, is_buy: true, status: true, size: 1,category_id: 349, brand_id: 3, user_id: user.id)

Product.create(name: "ナイキ フリース",price: 18999, state_id: 1, is_buy: true, size: 1,status: true, category_id: 340, brand_id: 4, user_id: user.id)
Product.create(name: "ナイキ 靴",price: 10000, state_id: 2, is_buy: true, status: true, size: 1,category_id: 380, brand_id: 4, user_id: user.id)
Product.create(name: "ナイキ バッグ",price: 1000, state_id: 3, is_buy: true, status: true, category_id: 393, brand_id: 4, user_id: user.id)
Product.create(name: "ナイキ ジャケット",price: 1000, state_id: 3, is_buy: true, status: true, size: 1,category_id: 349, brand_id: 4, user_id: user.id)

DelivaryOption.create(product_id: 1,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 2,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 3,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 4,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)

DelivaryOption.create(product_id: 5,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 6,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 7,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 8,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)

DelivaryOption.create(product_id: 9,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 10,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 11,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 12,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)

DelivaryOption.create(product_id: 13,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 14,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 15,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)
DelivaryOption.create(product_id: 16,shippingmethod_id: 1 , prefecture_id: 1, shippingday_id: 1, shippingpay_id: 1)

ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m73002812935_1.jpg?1544748498", product_id: 1);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m89761627917_1.jpg?1548658461", product_id: 2);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m72085284063_1.jpg?1551630616", product_id: 3);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m52640766325_1.jpg?1551831007", product_id: 4);

ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m26796235914_1.jpg?1552804711", product_id: 5);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m70231176925_1.jpg?1552701111", product_id: 6);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m17065768158_1.jpg?1552908473", product_id: 7);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m10658497282_1.jpg?1552900183", product_id: 8);

ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m62978504684_1.jpg?1551250921", product_id: 9);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m39545245841_1.jpg?1551607923", product_id: 10);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m68188008021_1.jpg?1552394261", product_id: 11);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m86211548203_1.jpg?1551755405", product_id: 12);

ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m62978504684_1.jpg?1551250921", product_id: 13);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m10786914789_1.jpg?1552722318", product_id: 14);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m50071390835_1.jpg?1552903377", product_id: 15);
ProductImage.create(image: "https://static.mercdn.net/item/detail/orig/photos/m46642025750_1.jpg?1552910159", product_id: 16);


