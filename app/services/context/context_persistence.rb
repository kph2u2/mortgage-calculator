module Context
  class ContextPersistence < BaseService
    attr_reader :interest_rate, :previous_interest_rate

    def initialize(params)
      @interest_rate =
        (params[:interest_rate].to_d / PRECISION_ADJUSTMENT_FACTOR).round(4)
    end

    def process_service_request
      context = ContextQuery.call.context
      @previous_interest_rate = context.interest_rate
      context.update_attributes!(interest_rate: @interest_rate) 
    rescue
      error("An internal error occurred updating the interest rate.")
    end

    def serializer_class
      ContextPersistenceSerializer
    end
  end
end
