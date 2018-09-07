module Amortization
  class Calculator
    def initialize(mortgage)
      @amortization_period = mortgage.period
      @payments_per_year = payments_per_year(mortgage.frequency)
    end

    def principal_from_payment(payment)
      (payment / expression_value).round(2)
    end

    def payment_from_principal(principal)
      (principal * expression_value).round(2)
    end

    private

    # The amortization formula can provide either the periodic payment amount
    # or the starting principal amount given the rest of the amortizaton
    # formula's expression is resolved. This method resolves that expression
    # value using the total_number_of_payments and periodic_interest_rate,
    # provided by amortization_inquiry, and retains it as an immutable value for
    # the remainder of the instance lifetime.
    def expression_value
      return @expression_value if defined?(@expression_value)

      subexpr_value =
        (1 + periodic_interest_rate) ** total_number_of_payments
      @expression_value =
        (periodic_interest_rate * subexpr_value) / (subexpr_value - 1)
    end

    def periodic_interest_rate
      @periodic_interest_rate ||= interest_rate / @payments_per_year
    end

    def total_number_of_payments
      @amortization_period * @payments_per_year
    end

    def interest_rate
      @interest_rate ||= Context::ContextQuery.call.context.interest_rate
    end

    def payments_per_year(frequency)
      Frequency.payments_per_year(frequency)
    end
  end
end
