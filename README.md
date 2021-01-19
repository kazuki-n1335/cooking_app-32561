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
  - http://54.168.151.171/

# テスト用アカウント
  1.テストアカウント1
    - email: test@test.com
    - password: a11111
<br>
  2.テストアカウント2
    - email: sample@sample.com
    - password: a11111
## ~~Basic認証~~
  - ~~ID~~
  - ~~Pass~~

# 利用方法
  ~~まずログインした後にトップページや各フォームの中にある材料登録フォームからレシピで使いたい食材や買い物リストや在庫を管理したい食材を登録してください(すでに登録している場合は不要)~~<br>
  次に各フォームから今の食材の在庫や買いたいものを登録して在庫、買い物リストを作成します。また作りたいレシピがあればレシピ投稿フォームからレシピを投稿します。<br>
  各フォームでは削除、編集が可能です。
  また、買い物リストでは、購入ボタンを押すことにより食材が在庫リストに追加されます。在庫にすでにある場合は、数量の所に数が加算されます。<br>

# 目指した課題解決
一人ぐらし等で料理する機会があまり多くなく冷蔵庫の中身を把握し切れていない人も、このアプリを使うことで、今、家にどんな食材があるかを把握でき、外にいながら投稿されたレシピを作るために足りない材料を知ることができるため、自炊の予定が立てやすくなります。

# 洗い出した要件
googleドキュメントの
[cooking_app-32561の要件定義](https://docs.google.com/spreadsheets/d/1uyXJGb-YfxHQYPv6HiKcgKNaJ10aVoCr9DYBuUNifs4/edit?usp=sharing)
を参照して下さい。

# 実装した機能についてのGIFと説明
  - __新規ユーザー登録、ログイン、ログアウト機能__<br>
  deviseを用いて、ユーザー登録機能を実装致しました。
  - __料理レシピ投稿機能__<br>
  調理レシピ投稿フォームを作り、レシピを投稿出来るようにしました。下部の、レシピ公開にチェックを入れないようにすると、自分のユーザー詳細ページにのみレシピが表示させることができます。<br>
  また投稿者なら自由に編集、削除、を行うことができます。<br>
  また、レシピタイトル検索機能と、レシピタグ機能を実装して、レシピを検索し易くしてます<br>
  詳細ページには、コメント機能と、お気に入り機能を追加しています。<br>
  - __作成予定料理レシピ管理機能__<br>
  レシピ詳細ページに、作成予定料理レシピフォームを実装して追加したレシピをmyページにて確認できます。
  - __ユーザー詳細機能__<br>
  ユーザー詳細ページには、次で紹介する食材在庫と買い物リスト、作成予定レシピ、自分が投稿したレシピと、お気に入りしたレシピを、一覧で見ることが出来ます。
  - __食材在庫管理機能__<br>
  myページにて、食材在庫を一覧表示で管理できます。在庫追加からページのフォームを記入することで、在庫を新しく追加できます。<br>
  また、ユーザー詳細ページから、個数の変更と、削除が可能です。
  - __買い物リスト管理機能__<br>
  myページにて、買い物リストを一覧表示で管理できます。リストへ追加からページのフォームを記入することで、買い物リストを新しく追加できます。<br>
  また、ユーザー詳細ページから、個数の変更と、削除が可能です。さらに購入ボタンをクリックすると、在庫に対象の食材が追加されます。またすでに、在庫に対象食材がある場合は、個数の欄が変更されます。


# 実装予定の機能
  現時点ではありません

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
| people   | integer    | null: false                    |
| food     | text       | null: false                    |
| making   | text       | null: false                    |
| introduce| text       |                                |
| release  | boolean    |                                |
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
| people     | integer    | null: false                    |
| date       | date       | null: false                    |
| recipe     | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe
- belongs_to :user

## stocksテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| num        | string     |                                |
| name       | string     | null: false                    |
| category   | integer    | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user

## shoppingsテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| num        | string     |                                |
| name       | string     | null: false                    |
| category   | integer    | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user

# ローカルでの動作方法
  - Rubyのバージョン: ruby 2.6.5p114
  - Railsのバージョン: Rails 6.0.3.4
  - MySQLのバージョン: mysql  Ver 14.14 Distrib 5.6.50, for osx10.15 (x86_64) using  EditLine wrapper