class CreateMortgageCalculatorContext < ActiveRecord::Migration[5.1]
  def change
    create_table :mortgage_calculator_contexts do |t|
      t.decimal :interest_rate, precision: 4, scale: 4
    end
  end
end
