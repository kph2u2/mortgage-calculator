module Calculator
  class MortgagePayment
    include Callable

    attr_reader :errors, :payment

    def initialize(params)
      @asking_price = params[:asking_price].to_d
      @down_payment = params[:down_payment].to_d
      @amortization_period = params[:amortization_period].to_i
      @payment_schedule = params[:payment_schedule]
      @errors = []
    end

    def call
      validate
      return self unless valid?

      process_service_request
      self
    end

    private

    def process_service_request
      @payment = mortgage.payment(@asking_price - @down_payment)
    end

    def mortgage
      Loan::Mortgage.new(@amortization_period, @payment_schedule)
    end

    def valid?
      !@errors.any?
    end

    def validate
      unless @asking_price > 0
        error("The asking price parameter must be larger than 0")
      end

      unless @down_payment > 0
        error("The down payment value must be numeric and larger than 0")
      end

      unless valid_period_value?(@amortization_period)
        error("The amortization period value be within #{Loan::Mortgage::AMORTIZATION_RANGE} years")
      end

      unless valid_frequency_value?(@payment_schedule)
        error("The payment schedule value must be one of \'#{Amortization::Frequency::PAYMENTS_PER_YEAR.keys.join("','")}")
      end

      unless @asking_price > @down_payment
        error("The asking price value must be greater than the down payment value")
      end

      unless sufficient_down_payment?
        error("The down payment is not sufficient for the asking price")
      end
    end

    def valid_frequency_value?(payment_schedule)
      Amortization::Frequency.valid_frequency?(payment_schedule)
    end

    def valid_period_value?(period)
      Loan::Mortgage.valid_mortgage_period?(period)
    end

    def sufficient_down_payment?
      Loan::Mortgage.sufficient_down_payment?(@down_payment, @asking_price)
    end

    def error(error)
      @errors << error
    end
  end
end
