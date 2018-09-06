module Loan
  class Mortgage
    DOWN_PAYMENT_THRESHOLD = 500000
    DOWN_PAYMENT_BASE = 25000
    BASE_PERCENTAGE = "0.05".to_d
    ADDITIONAL_PERCENTAGE = "0.1".to_d
    AMORTIZATION_RANGE = 5..25

    attr_reader :period, :frequency

    def initialize(period, frequency, down_payment=0)
      @period = period
      @down_payment = down_payment
      @frequency = frequency
    end

    def self.valid_mortgage_period?(number_of_years)
      AMORTIZATION_RANGE.include?(number_of_years)
    end

    def sufficient_down_payment?(requested_amount)
      @down_payment >= minimum_down_payment(requested_amount)
    end

    private

    def minimum_down_payment(requested_amount)
      return @minimum_down_payment if defined?(@minimum_down_payment)

      @minimum_down_payment =
        if requested_amount > DOWN_PAYMENT_THRESHOLD
          DOWN_PAYMENT_BASE +
          (ADDITIONAL_PERCENTAGE * (requested_amount - DOWN_PAYMENT_THRESHOLD))
        else
          BASE_PERCENTAGE * requested_amount
        end

      @minimum_down_payment.round(2)
    end
  end
end
