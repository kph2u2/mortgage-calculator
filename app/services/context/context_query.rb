module Context
  class ContextQuery < BaseService
    attr_reader :context

    def initialize
      @context = MortgageCalculatorContext.first_or_create!(
                   interest_rate: DEFAULT_INTEREST_RATE
                 )
    end
  end
end
