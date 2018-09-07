module Calculator
  class MortgageAmount < ServiceBase
    attr_reader :amount

    def initialize(params)
      @payment_amount = params[:payment_amount].to_d
      @down_payment = params[:down_payment].to_d
      @amortization_period = params[:amortization_period].to_i
      @payment_schedule = params[:payment_schedule]
      @errors = []
    end

    private

    def process_service_request
      @amount = mortgage.amount(@payment_amount)
    end

    def mortgage
      Loan::Mortgage.new(@amortization_period, @payment_schedule)
    end

    def validate
      unless @payment_amount > 0
        error("The payment amount value must be greater than 0")
      end

      unless valid_period_value?
        error("The amortization period value must be within #{Loan::Mortgage::AMORTIZATION_RANGE} years")
      end

      unless valid_frequency_value?
        error("The payment schedule value must be one of \'#{Amortization::Frequency::PAYMENTS_PER_YEAR.keys.join("','")}")
      end
    end

    def valid_frequency_value?
      Amortization::Frequency.valid_frequency?(@payment_schedule)
    end

    def valid_period_value?
      Loan::Mortgage.valid_mortgage_period?(@amortization_period)
    end
  end
end
