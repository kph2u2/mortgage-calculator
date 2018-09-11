module Calculator
  class MortgageAmount < BaseService
    attr_reader :amount

    private

    def self.parameter_class
      Calculator::MortgageAmountParameters
    end

    def self.serializer_class
      MortgageAmountSerializer
    end

    def self.permitted_parameters
      [
        :payment_amount,
        :payment_schedule,
        :amortization_period,
        :down_payment,
      ]
    end

    def process_service_request
      calculate_principal
      calculate_insurance_cost
      set_amount
    end

    def set_amount
      @amount = @principal + @params.down_payment + @insurance_cost
    end

    def calculate_insurance_cost
      @insurance_cost = @params.down_payment > 0 ? insurance.cost : 0
    end

    def calculate_principal
      @principal = mortgage.principal(@params.payment_amount)
    end

    def mortgage
      Loan::Mortgage.new(@params.amortization_period, @params.payment_schedule)
    end

    def insurance
      Loan::Insurance.new(@principal, @params.down_payment)
    end
  end
end
