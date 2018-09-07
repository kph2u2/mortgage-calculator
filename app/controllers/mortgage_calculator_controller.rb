class MortgageCalculatorController < ApplicationController
  def payment_amount
    render_results(Calculator::MortgagePayment.call(payment_amount_parameters))
  end

  def mortgage_amount
    render_results(Calculator::MortgageAmount.call(mortgage_amount_parameters))
  end

  def update
    render_results(Context::ContextPersistence.call(update_parameters))
  end

  private

  def payment_amount_parameters
    params.require(payment_required_parameters)
    params.permit(*payment_permitted_parameters)
  end

  def payment_required_parameters
    [
      :asking_price,
      :down_payment,
      :payment_schedule,
      :amortization_period,
    ]
  end

  def payment_permitted_parameters
    payment_required_parameters << :finance_insurance
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

  def update_parameters
    params.require(:mortgage_calculator).permit(:interest_rate)
  end

  private

  def render_results(service)
    if service.errors.any?
      render json: service, serializer: ServiceErrorSerializer, status: :unprocessable_entity
    else
      render json: service, serializer: service.serializer_class
    end 
  end
end
