# rubocop:disable Lint/MissingCopEnableDirective, Layout/IndentationStyle, Layout/IndentationWidth, Style/ConditionalAssignment, Style/RedundantReturn, Metrics/MethodLength, Layout/ExtraSpacing, Layout/SpaceAroundOperators, Style/FrozenStringLiteralComment, Layout/LineLength, Style/Documentation, Metrics/ParameterLists
require 'date'
require 'pry'

class Promotion
	attr_reader :product, :value, :discount, :min_amount, :min_quantity, :expiry_date

	def initialize(product: 'all', value: true, discount: 0, expiry_date: Date.today.next_year, min_amount: 0, min_quantity: 0)
	  @product 				 = product
	  @value 					 = value
	  @discount 			 = discount
	  @min_amount 		 = min_amount
	  @min_quantity    = min_quantity
	  @expiry_date 		 = expiry_date
	end

	def self.apply_promotions(promotions, items)
		discounted_items = items

		total_discount_promotions = []
		promotions.each do |promotion|
			if promotion.product != 'all'
				discounted_items = promotion.apply_item_promotion(discounted_items)
			else
				total_discount_promotions << promotion
			end
		end

		total = Product.calculate_total(discounted_items)

		discounted_amount_from_total = 0
		total_discount_promotions.each do |promotion|
			discounted_amount_from_total += promotion.apply_total_discount(discounted_items)
		end

		return (total - discounted_amount_from_total), discounted_items
	end

	def apply_item_promotion(discounted_items)
		promotion = self

		item  = discounted_items[promotion.product]
		price = item[:price]

		if item[:quantity] >= min_quantity
			if promotion.value
				price -= promotion.discount
			else
				price -= (price * promotion.discount / 100)
			end
			discounted_items[promotion.product][:price] = price
		end

		discounted_items
	end

	def apply_total_discount(discounted_items)
		promotion = self

		total = Product.calculate_total(discounted_items)
		total_discount = 0

		if total >= min_amount
			if promotion.value
				total_discount = promotion.discount
			else
        total_discount = (total * promotion.discount / 100)
			end
		end

		total_discount
	end
end
