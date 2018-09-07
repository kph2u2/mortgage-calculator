class MortgageCalculatorContext < ApplicationRecord
  validates :interest_rate, presence: true, numericality: { greater_than: 0, less_than: 1 }
end
