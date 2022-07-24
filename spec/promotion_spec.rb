require 'rspec'
require_relative '../promotion.rb'
require_relative '../checkout.rb'
require_relative '../product.rb'

describe Promotion do

	let (:product_1) { Product.new('001', 'Lavender heart', 9.25) }
	let (:product_2) { Product.new('002', 'Personalised cufflinks', 45) }
	let (:product_3) { Product.new('003', 'Kids T-shirt', 19.95) }

	let (:promotion_1) { Promotion.new(product: 'all', value: false, discount: 10, expiry_date: Date.today.next_year, min_amount: 60) }
	let (:promotion_2) { Promotion.new(product: '001', value: true, discount: 0.75, expiry_date: Date.today.next_year, min_quantity: 2) }

	let (:promotional_rules) { [promotion_1, promotion_2] }
	let (:co) { Checkout.new(promotional_rules) }

	context 'when only overall promotion is applied' do

		it 'applies promotion on the total amount correctly' do
			co.scan(product_1)
			co.scan(product_2)
			co.scan(product_2)
			co.scan(product_3)

			total = co.total

			expect(total).to eq 107.28
		end
	end

	context 'when only item promotion is applied' do

		it 'applies promotion on the items correctly' do
			co.scan(product_1)
			co.scan(product_1)

			total = co.total

			expect(total).to eq 17
		end

		context 'when multiple items promotions are applied' do
			let (:promotion_3) { Promotion.new(product: '002', value: true, discount: 5, expiry_date: Date.today.next_year, min_quantity: 1) }
			let (:promotional_rules) { [promotion_1, promotion_2, promotion_3] }

			it 'applies promotion on the items correctly' do
				co.scan(product_1)
				co.scan(product_1)
				co.scan(product_2)

				total = co.total

				expect(total).to eq 57
			end

		end

	end

	context 'when both item and overall promotions are applied' do
		it 'applies promotion on the items correctly' do
			co.scan(product_1)
			co.scan(product_2)
			co.scan(product_1)
			co.scan(product_3)

			total = co.total

			expect(total).to eq 73.755
		end
	end
end