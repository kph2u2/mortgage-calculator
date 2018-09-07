class MortgagePaymentSerializer < ActiveModel::Serializer
  attributes :payment

  def payment
    object.payment
  end
end
