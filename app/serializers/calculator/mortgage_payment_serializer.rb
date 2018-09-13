module Calculator
  class MortgagePaymentSerializer < ActiveModel::Serializer
    attributes :payment

    def payment
      object.payment.to_s
    end
  end
end
