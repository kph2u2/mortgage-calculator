module Calculator
  class MortgagePayment < BaseService
    attr_reader :payment

    private

    def self.parameter_class
      Calculator::MortgagePaymentParameters
    end

    def self.serializer_class
      Calculator::MortgagePaymentSerializer
    end

    def self.permitted_parameters
      [
        :asking_price,
        :down_payment,
        :payment_schedule,
        :amortization_period,
        :finance_insurance,
      ]
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
      @principal = @params.asking_price - @params.down_payment
    end

    def calculate_insurance_cost
      @insurance_cost = @params.finance_insurance ? insurance.cost : Money.new(0)
    end

    def insurance
      Loan::Insurance.new(@principal, @params.down_payment)
    end

    def mortgage
      Loan::Mortgage.new(@params.amortization_period, @params.payment_schedule)
    end
  end
end
