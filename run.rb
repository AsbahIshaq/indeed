require_relative 'promotion.rb'
require_relative 'checkout.rb'
require_relative 'product.rb'


product_1 = Product.new('001', 'Lavender heart', 9.25)
product_2 = Product.new('002', 'Personalised cufflinks', 45)
product_3 = Product.new('003', 'Kids T-shirt', 19.95)

promotion_1 = Promotion.new(product: 'all', value: false, discount: 10, expiry_date: Date.today.next_year, min_amount: 60)
promotion_2 = Promotion.new(product: '001', value: true, discount: 0.75, expiry_date: Date.today.next_year, min_quantity: 2)

promotional_rules = [promotion_1, promotion_2]
co = Checkout.new(promotional_rules)


# co.scan(product_1)
# co.scan(product_2)
# co.scan(product_3)


# co.scan(product_1)
# co.scan(product_3)
# co.scan(product_1)

co.scan(product_1)
co.scan(product_2)
co.scan(product_1)
co.scan(product_3)

puts co.total