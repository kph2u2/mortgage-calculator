module Calculator
  class MortgagePayment < BaseService
    attr_reader :payment

    def initialize(params)
      @asking_price = params[:asking_price].to_d
      @down_payment = params[:down_payment].to_d
      @amortization_period = params[:amortization_period].to_i
      @payment_schedule = params[:payment_schedule]
      @finance_insurance = finance_insurance?(params[:finance_insurance])
      @errors = []
    end

    def serializer_class
      MortgagePaymentSerializer
    end

    private

    def self.required_parameters
      [
        :asking_price,
        :down_payment,
        :payment_schedule,
        :amortization_period,
      ]
    end

    def self.permitted_parameters
      required_parameters
    end

    def process_service_request
      calculate_principal
      calculate_insurance_cost
      set_payment
    end

    def set_payment
      @payment = mortgage.payment(@principal + @insurance_cost)
    end

    def calculate_principal
      @principal = @asking_price - @down_payment
    end

    def calculate_insurance_cost
      @insurance_cost = @finance_insurance ? insurance.cost : 0
    end

    def insurance
      Loan::Insurance.new(@principal, @down_payment)
    end

    def mortgage
      Loan::Mortgage.new(@amortization_period, @payment_schedule)
    end

    def validate
      unless @asking_price > 0
        error("The asking price value must be greater than 0")
      end

      unless @down_payment > 0
        error("The down payment value must be greater than 0")
      end

      unless valid_period_value?
        error("The amortization period value must be within #{Loan::Mortgage::AMORTIZATION_RANGE} years")
      end

      unless valid_frequency_value?
        error("The payment schedule value must be one of \'#{Amortization::Frequency::PAYMENTS_PER_YEAR.keys.join("','")}")
      end

      unless @asking_price > @down_payment
        error("The asking price value must be greater than the down payment value")
      end

      unless sufficient_down_payment?
        error("The down payment is not sufficient for the asking price")
      end
    end

    def valid_frequency_value?
      Amortization::Frequency.valid_frequency?(@payment_schedule)
    end

    def valid_period_value?
      Loan::Mortgage.valid_mortgage_period?(@amortization_period)
    end

    def sufficient_down_payment?
      Loan::Mortgage.sufficient_down_payment?(@down_payment, @asking_price)
    end

    def finance_insurance?(flag)
      flag ? flag == "true" : false
    end
  end
end
