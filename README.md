# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
# テーブル設計

## users テーブル

| Column                    | Type    | Options                   |
| ------------------------- | ------  | ------------------------- |
| email                     | string  | null: false, unique: true |
| encrypted_password        | string  | null: false               |
| nickname                  | string  | null: false               |
| last_name                 | string  | null: false               |
| first_name                | string  | null: false               |
| last_name_reading         | string  | null: false               |
| first_name_reading        | string  | null: false               |
| birth_date                | integer | null: false               |

### Association
- has_many :item
- has_many :shipping_to
- has_many :purchase_records

## items テーブル

| Column               | Type       |Options                         |
| -------------------- | ---------- |------------------------------- |
| name                 | string     | null: false                    |
| explanation          | text       | null:false                     |
| category             | integer    | null:false                     |
| situation            | integer    | null: false                    |
| delivery_charge      | integer    | null: false                    |
| sender_area          | integer    | null:false                     |
| days_required        | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null; false, foreign_key: true |

### Association
- belongs_to :user
- has_many :purchase_records

## shipping_to テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | integer    | null: false                    |
| prefectures        | integer    | null: false                    |
| municipality       | string     | null:false                     |
| address            | string     | null: false                    |
| building_name      | string     | null: false                    |
| phone_number       | integer    | null:false                     |
| user               | references | null:false, foreign_key: true  |

### Association
- belongs_to :user
- has_one :purchase_records

## purchase_records テーブル

| Column       | Type           | Options                             |
| ------------ | -------------- | ----------------------------------- |
| user         | references     | null: false, foreign_key: true      |
| item         | references     | null: false, foreign_key: true      |

### Association
- belongs_to :item
- belongs_to :user
- belongs_to :shipping_to

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
