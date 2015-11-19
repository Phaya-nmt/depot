Order.transaction do
  (1..100).each do |i|
  Order.create(:name => "Customer #{i}", 
               :address => "#{i} Main Street", 
               :email => "customer-#{i}@example.com", 
               :pay_tipe => "現金")
  end
end