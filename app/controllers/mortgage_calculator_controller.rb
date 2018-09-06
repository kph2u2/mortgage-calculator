class MortgageCalculatorController < ApplicationController
  def payment_amount
    service = Calculator::MortgagePayment.call(payment_amount_parameters)

    if service.errors.any?
      render json: { errors: service.errors }, status: :unprocessable_entity
    else
      render json: { payment: service.payment }
    end 
  end

  private

  def payment_amount_parameters
    params.require(payment_required_parameters)
    params.permit(*payment_permitted_parameters)
  end

  def payment_required_parameters
    payment_permitted_parameters
  end

  def payment_permitted_parameters
    [
      :asking_price,
      :down_payment,
      :payment_schedule,
      :amortization_period,
    ]
  end
end
