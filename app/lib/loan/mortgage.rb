module Loan
  class Mortgage
    DOWN_PAYMENT_THRESHOLD = Money.new(50000000)
    DOWN_PAYMENT_BASE = Money.new(2500000)
    BASE_PERCENTAGE = 0.05.to_d
    ADDITIONAL_PERCENTAGE = 0.1.to_d
    AMORTIZATION_RANGE = 5..25

    attr_reader :period, :frequency

    def initialize(period, frequency)
      @period = period
      @frequency = frequency
      @calculator = Amortization::Calculator.new(self)
    end

    def self.valid_mortgage_period?(number_of_years)
      AMORTIZATION_RANGE.include?(number_of_years)
    end

    def self.sufficient_down_payment?(down_payment, requested_amount)
      down_payment >= minimum_down_payment(requested_amount)
    end

    def payment(principal_amount)
      @calculator.payment_from_principal(principal_amount)
    end

    def principal(payment_amount)
      @calculator.principal_from_payment(payment_amount)
    end

    private

    def self.minimum_down_payment(requested_amount)
      @minimum_down_payment =
        if requested_amount > DOWN_PAYMENT_THRESHOLD
          DOWN_PAYMENT_BASE +
          ((requested_amount - DOWN_PAYMENT_THRESHOLD) * ADDITIONAL_PERCENTAGE)
        else
          requested_amount * BASE_PERCENTAGE
        end

      @minimum_down_payment
    end
  end
end
