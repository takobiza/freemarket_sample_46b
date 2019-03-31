# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|image|string|null: false|
|message|text||
|pay_id|string||
deviceで追加されるもの

### Association
- has_one :sns_credentials, dependent: destroy
- has_one :user_detail, dependent: destroy
- has_one :user_address, dependent: destroy
- has_many :products, dependent: destroy
- has_many :favorites, dependent: destroy
- has_many :comments, dependent: destroy
- has_many :purchase_seller, :class_name => 'Purchase', :foreign_key => 'seller_id'
- has_many :purchase_of_buyer, :class_name => 'Purchase', :foreign_key => 'buyer_id'
- has_many :products_of_seller, :through => :purchase_of_seller, :source => 'product'
- has_many :products_of_buyer, :through => :purchase_of_buyer, :source => 'product'

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|uid|string||
|provider|string||

### Association
- belongs_to :user

## user_detailsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|family_name|string|null: false|
|given_name|string|null: false|
|family_name_kana|string|null: false|
|given_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|postal_code|string||
|prefectures|integer||
|city|string||
|block|string||
|building|string||
|phone_number|integer|null: false|

### Association
- belongs_to :user

## user_addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|family_name|string|null: false|
|given_name|string|null: false|
|family_name_kana|string|null: false|
|given_name_kana|string|null: false|
|postal_code|string|null: false|
|prefectures|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|phone_number|integer||

### Association
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null:false, foreign_key: true|
|name|string|null: false,index: true|
|description|text|null: false|
|size|integer||
|state|integer||
|price|integer|null: false|
|status|boolean|null:false, default: true |
|is_buy|boolean|null:false, default: true |

### Association
- has_one :deliveryoption, dependent: destroy
- has_many :productimages, dependent: destroy
- belongs_to :category
- belongs_to :brand
- has_many :favorites, dependent: destroy
- has_many :comments, dependent: destroy
- has_many :purchase, dependent: destroy

## delivary_optionsテーブル
|Column|Type|Options|
|------|----|-------|
|products_id|references|null: false, foreign_key: true|
|burden|integer|null: false|
|method|integer|null: false|
|prefecture|integer|null: false|
|days|integer|null: false|

### Association
- belongs_to :product


## product_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|products_id|references|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to :product

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,index: true|
|ancestry|string|null:false|

### Association
- has_manys :products, dependent: destroy

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,index: true|

### Association
- has_manys :products, dependent: destroy

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|message|text|null: false|
|user_id|references|null:false, foreign_key: true|
|product_id|references|null:false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product

## favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key: true|
|product_id|references|null:false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product

## purchaseテーブル
|Column|Type|Options|
|------|----|-------|
|buyer_id|references|null:false, foreign_key: true|
|seller_id|references|null:false, foreign_key: true|
|product_id|references|null:false, foreign_key: true|
|price_pay|integer|null: false|
|rate|integer|null: false|

### Association
- belongs_to :product
- belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
- belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
