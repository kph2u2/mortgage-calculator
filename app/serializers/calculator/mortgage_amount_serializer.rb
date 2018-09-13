class Calculator::MortgageAmountSerializer < ActiveModel::Serializer
  attributes :amount

  def amount
    object.amount.to_s
  end
end
