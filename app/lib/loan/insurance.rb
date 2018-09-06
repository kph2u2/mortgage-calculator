module Loan
  class Insurance
    PERCENT_INSURANCE_THRESHOLD = "0.2".to_d
    AMOUNT_INSURANCE_THRESHOLD = 1000000

    def initialize(amount, down_payment)
      @amount = amount
      @down_payment = down_payment
    end

    def cost
      return 0 unless insurance_available?
      (insurance_cost_percentage * @amount).round(2)
    end

    private

    def insurance_cost_percentage
      case down_payment_percentage
      when "0.05".to_d .. "0.0999".to_d
        "0.0315".to_d
      when "0.1".to_d .. "0.1499".to_d
        "0.024".to_d
      when "0.15".to_d .. "0.1999".to_d
        "0.018".to_d
      else
        "0".to_d
      end
    end

    def down_payment_percentage
      (@down_payment.to_d / @amount).round(4)
    end

    def insurance_available?
      @amount < AMOUNT_INSURANCE_THRESHOLD ||
      down_payment_percentage < PERCENT_INSURANCE_THRESHOLD
    end
  end
end
