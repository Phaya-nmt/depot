# カートから見たアイテムに対する処理
class Cart < ActiveRecord::Base
  # 一つのカートに複数アイテムを保持する
  has_many :line_items, dependent: :destroy
  # dependent: :destroyは情報を破棄した時に削除する処理
  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
  current_item
  end
def total_price
  line_items.to_a.sum {|item| item.total_price }
end
end