require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  test "buying a product" do
    LineItem.delete_all         #初期化処理
    Order.delete_all            #初期化処理
    ruby_book = products(:ruby) #購入したい本
    # ここまでが最初の準備

    get "/"                     #http://localhost:3000にアクセス
    assert_response :success
    assert_template "index"


    post_via_redirect "/line_items", product_id: ruby_book.id
    assert_response :success
    assert_template "show"

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
                      order: {
                      name: "Dave Thomas",
                      adress:"123 The Street",
                      email:"dave@example.com",
                      pay_type:"現金"
                    }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    orders = Order.all
    assert_equal 1, orders.size
    order = order[0]

    assert_equal"Dave Thomas",order.name
    assert_equal"123 The Street",order.adress
    assert_equal"dave@example",order.email
    assert_equal"現金",order.pay_type


  end


end
