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
- has_many :buyer_purchase, class_name: 'User', :foreign_key => 'buyer_id'
- has_many :exhibitor_transactions, class_name: 'User', :foreign_key => 'exhibitor_id'

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|uid|string||
|provider|string||

### Association
- belongs_to :user

## user_detailテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|name|string|null: false|
|name_kana|string|null: false|
|birth|string|null: false|
|postal_code|string||
|prefectures|integer||
|city|string||
|block|string||
|building|string||
|phone_number|string|null: false|

### Association
- belongs_to :user

## user_addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|name|string|null: false|
|name_kana|string|null: false|
|postal_code|string|null: false|
|prefectures|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|phone_number|string||

### Association TODO
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
|is_buy|boolean|null:false, default: true |

### Association ToDo
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

### Association ToDo
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
|exhibitor_id|references|null:false, foreign_key: true|
|product_id|references|null:false, foreign_key: true|
|price_pay|integer|null: false|

### Association
- belongs_to :buyer, class_name: 'User', :foreign_key => 'buyer_id'
- belongs_to :exhibitor, class_name: 'User', :foreign_key => 'exhibitor_id'
- belongs_to :product
