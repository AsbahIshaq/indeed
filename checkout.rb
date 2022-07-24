class Checkout

	attr_reader :scanned_items, :promotional_rules

	def initialize(promotional_rules)
		@scanned_items 		 = {}
		@promotional_rules = promotional_rules
	end

	def scan(item)
		code  = item.product_code
		price = item.price

		if @scanned_items[code]
			@scanned_items[code][:quantity] = @scanned_items[code][:quantity] + 1
		else
			@scanned_items[code] = { quantity: 1, price: price }
		end
	end

	def total
		total, final_prices = Promotion.apply_promotions(@promotional_rules, @scanned_items)

		total
	end

end