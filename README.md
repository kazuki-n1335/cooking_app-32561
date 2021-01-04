# README

# アプリケーション名
__cooking_app-32561__

# アプリケーション概要
## 食材在庫管理機能
  - 食材在庫追加
  - 食材在庫編集
  - 食材在庫削除
  - 食材在庫一覧
## 料理レシピ投稿機能
  - 料理レシピ新規投稿
  - 料理レシピ編集
  - 料理レシピ削除
  - 料理レシピ一覧
  - 料理レシピ検索
  - 料理レシピへのコメント機能
  - 料理レシピへのお気に入り機能
  - 作成予定料理レシピ管理機能
## 買い物リスト管理機能
  - 買い物リスト追加
  - 買い物リスト編集
  - 買い物リスト削除
  - 買い物リスト一覧

# URL

# テスト用アカウント
  - email: 
  - password: 
  ## Basic認証
  - ID
  - Pass

# 利用方法
  まずログインした後にトップページや各フォームの中にある材料登録フォームからレシピで使いたい食材や買い物リストや在庫を管理したい食材を登録してください(すでに登録している場合は不要)
  次に各フォームから今の食材の在庫や買いたいものを登録して在庫、買い物リストを作成します。また作りたいレシピがあればレシピ投稿フォームからレシピを投稿します。
  そうすると投稿されたレシピを作った際や買い物リストにある物を買った際に特定のボタンを押すことで食材在庫を自動的に管理します。
  各フォームでは削除、編集が可能です。

# 目指した課題解決
一人ぐらし等で料理する機会があまり多くなく冷蔵庫の中身を把握し切れていない人もこのアプリを使うことで今家にどんな食材があるかを把握でき、外にいながら投稿されたレシピを作るために足りない材料を知ることができるため自炊の予定が立てやすくなります。

# 洗い出した要件

# 実装した機能についてのGIFと説明

# 実装予定の機能

# テーブル設計

## users テーブル

| Column              | Type    | Options                |
| ------------------- | ------- | ---------------------- |
| nickname            | string  | null: false            |
| email               | string  | add_index unique: true |
| encrypted_password  | string  | null: false            |

### Association
- has_many :recipes
- has_many :likes
- has_many :comments
- has_many :plans
- has_many :stocks
- has_many :shoppings



## recipesテーブル

| Column   | Type       | Options                        |
| ---------| ---------- | ------------------------------ |
| title    | string     | null: false                    |
| making   | text       | null: false                    |
| introduce| text       |                                |
| user_id  | references | null: false, foreign_key: true |

### Association
- has_one_attached :image
- belongs_to :user
- has_many :ingredient
- has_many :recipe_tags, through: recipe_tag_relations
- has_many :recipe_tag_relations
- has_many :likes, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :plans


## ingredientsテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| amount   | string     | null: false                    |
| recipe   | references | null: false, foreign_key: true |
| user     | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe

## recipe_tag_relationsテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| recipe     | references | null: false, foreign_key: true |
| recipe_tag | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe
- belongs_to :recipe_tag

## recipe_tagsテーブル

| Column   | Type    | Options                     |
| ---------| ------- | --------------------------- |
| tag      | string  | null: false uniqueness: true|

### Association
- has_many :recipes, through: recipe_tag_relations
- has_many :recipe_tag_relations

## likesテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| recipe     | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |
| index      |            | unique: true                   |
### Association
- belongs_to :recipe
- belongs_to :user

## commentsテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | string     | null: false                    |
| recipe     | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe
- belongs_to :user

## plansテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | integer    | null: false                    |
| date       | date       | null: false                    |
| recipe     | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe
- belongs_to :user

## stocksテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| num        | string     | null: false                    |
| name       | string     | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user

## shoppingsテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| num        | string     | null: false,                   |
| name       | string     | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user

# ローカルでの動作方法
  - Rubyのバージョン: 