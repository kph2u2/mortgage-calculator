class MortgageCalculatorController < ApplicationController
	def payment_amount
		puts "payment_amount #{payment_amount_parameters}"
	end

	private

	def payment_amount_parameters
		params.require(required_parameters)
		params.permit(*permitted_parameters)
	end

	def required_parameters
		[
			:asking_price,
			:down_payment,
			:payment_schedule,
			:amortization_period,
		]
	end

	def permitted_parameters
		required_parameters
	end
end
