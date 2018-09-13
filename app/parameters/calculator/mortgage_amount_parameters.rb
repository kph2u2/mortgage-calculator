module Calculator
  class MortgageAmountParameters < SimpleParams::Params
    include MortgageValidations

    param :payment_amount, type: :money, validations: { numericality: { greater_than: 0 }, presence: true }
    param :down_payment, type: :money, default: Money.new(0)
    param :payment_schedule, type: :string, validations: { presence: true }
    param :amortization_period, type: :integer, validations: { presence: true }

    validate  :valid_amortization_period_value?
    validate  :valid_frequency_value?
  end
end
