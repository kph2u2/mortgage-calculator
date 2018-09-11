class MortgageCalculatorController < ApplicationController
  def payment_amount
    render_results(Calculator::MortgagePayment, params)
  end

  def mortgage_amount
    render_results(Calculator::MortgageAmount, params)
  end

  def update
    render_results(
      Context::ContextPersistence, params.require(:mortgage_calculator)
    )
  end

  private

  def render_results(service_class, params)
    service = service_class.call(params)
    if service.errors.any?
      render json: service, serializer: ServiceErrorSerializer, status: :unprocessable_entity
    else
      render json: service, serializer: service_class.serializer_class
    end 
  end
end
