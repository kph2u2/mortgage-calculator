module MortgageValidations
  extend ActiveSupport::Concern

  def sufficient_down_payment?
    if down_payment &&
       asking_price &&
       !Loan::Mortgage.sufficient_down_payment?(down_payment, asking_price)
      errors.add(
        :down_payment_ratio,
        "Down payment is not sufficient for the asking price"
      )
    end
  end

  def valid_amortization_period_value?
    if amortization_period &&
       !Loan::Mortgage.valid_mortgage_period?(amortization_period)
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
    if payment_schedule &&
       !Amortization::Frequency.valid_frequency?(payment_schedule)
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
    if interest_rate && !(1..99).include?(interest_rate)
      errors.add(
        :interest_rate,
        "Interest rate must be in the range of 1..99 percent"
      )
    end
  end
end
