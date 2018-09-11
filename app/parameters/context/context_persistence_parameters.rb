module Context
  class ContextPersistenceParameters < SimpleParams::Params
    include MortgageValidations

    param :interest_rate, type: :decimal, validations: { numericality: { greater_than: 0 }, presence: true }

    validate :valid_interest_rate_range?
  end
end
