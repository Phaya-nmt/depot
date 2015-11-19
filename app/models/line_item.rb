class LineItem < ActiveRecord::Base
  # belongss_toメソッドにより参照元テーブルから参照先テーブルにアクセス
  # LineItemからproductとcartに関連がある証明的な？
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  def total_price
    product.price * quantity
  end
end
