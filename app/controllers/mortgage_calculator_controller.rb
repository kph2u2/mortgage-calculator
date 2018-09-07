class MortgageCalculatorController < ApplicationController
  def payment_amount
    service = Calculator::MortgagePayment.call(payment_amount_parameters)

    if service.errors.any?
      render json: { errors: service.errors }, status: :unprocessable_entity
    else
      render json: { payment: service.payment }
    end 
  end

  def mortgage_amount
    service = Calculator::MortgageAmount.call(mortgage_amount_parameters)

    if service.errors.any?
      render json: { errors: service.errors }, status: :unprocessable_entity
    else
      render json: { payment: service.amount }
    end 
  end

  def update
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

  def mortgage_amount_parameters
    params.require(amount_required_parameters)
    params.permit(*amount_permitted_parameters)
  end

  def amount_required_parameters
    [
      :payment_amount,
      :payment_schedule,
      :amortization_period,
    ]
  end

  def amount_permitted_parameters
    amount_required_parameters << :down_payment
  end
end
