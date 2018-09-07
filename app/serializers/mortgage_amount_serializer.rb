class MortgageAmountSerializer < ActiveModel::Serializer
  attributes :amount

  def amount
    object.amount
  end
end
