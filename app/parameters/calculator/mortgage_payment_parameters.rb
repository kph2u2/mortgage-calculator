module Calculator
  class MortgagePaymentParameters < SimpleParams::Params
    include MortgageValidations

    param :asking_price, type: :money, validations: { numericality: { greater_than: 0 }, presence: true }
    param :down_payment, type: :money, validations: { numericality: { greater_than: 0 }, presence: true }
    param :payment_schedule, type: :string, validations: { presence: true }
    param :amortization_period, type: :integer, validations: { presence: true }
    param :finance_insurance, type: :boolean, default: false

    validate  :valid_amortization_period_value?
    validate  :sufficient_down_payment?
    validate  :valid_frequency_value?
  end
end
