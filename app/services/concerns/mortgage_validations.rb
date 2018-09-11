module MortgageValidations
  extend ActiveSupport::Concern

  def sufficient_down_payment?
    unless Loan::Mortgage.sufficient_down_payment?(down_payment, asking_price)
      errors.add(
        :down_payment_ratio,
        "Down payment is not sufficient for the asking price"
      )
    end
  end

  def valid_asking_price?
    unless asking_price > 0
      errors.add(:asking_price, "The asking price value must be greater than 0")
    end
  end

  def valid_down_payment?
    unless down_payment > 0
      errors.add(:down_payment, "The down payment value must be greater than 0")
    end
  end

  def valid_amortization_period_value?
    unless Loan::Mortgage.valid_mortgage_period?(amortization_period)
      errors.add(
        :amortization_period,
        %W[
          The amortization period value must be within 
          #{Loan::Mortgage::AMORTIZATION_RANGE} years
        ].join(' ')
      )
    end
  end

  def valid_frequency_value?
    unless Amortization::Frequency.valid_frequency?(payment_schedule)
      errors.add(
        :frequency_value,
        %W[
          The payment schedule value must be one of 
          #{Amortization::Frequency::PAYMENTS_PER_YEAR.keys.join("','")}
        ].join(' ')
      )
    end
  end

  def valid_interest_rate_range?
    unless (1..99).include?(interest_rate)
      errors.add(
        :interest_rate,
        "Interest rate must be in the range of 1..99 percent"
      )
    end
  end
end
