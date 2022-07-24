class Product
  attr_reader :product_code, :product_name, :price

  def initialize(product_code, product_name, price)
    @product_code = product_code
    @product_name = product_name
    @price        = price
  end

  def self.calculate_total(items)
    total = 0
    items.each do |item|
      total = total + (item[1][:quantity] * item[1][:price])
    end
    
    total
  end

end
