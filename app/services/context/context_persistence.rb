module Context
  class ContextPersistence < BaseService
    attr_reader :interest_rate, :previous_interest_rate

    private

    def self.parameter_class
      ContextPersistenceParameters
    end

    def self.serializer_class
      ContextPersistenceSerializer
    end

    def self.permitted_parameters
      [:interest_rate]
    end

    def process_service_request
      @interest_rate =
        (@params.interest_rate / PRECISION_ADJUSTMENT_FACTOR).round(4)
      context = ContextQuery.call.context
      @previous_interest_rate = context.interest_rate
      context.update_attributes!(interest_rate: @interest_rate) 
    rescue
      error("An internal error occurred updating the interest rate.")
    end
  end
end
