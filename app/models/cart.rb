# カートから見たアイテムに対する処理
class Cart < ActiveRecord::Base
  # 一つのカートに複数アイテムを保持する
  has_many :line_items, dependent: :destroy
  # dependent: :destroyは情報を破棄した時に削除する処理
end
