class BaseService
  include Callable

  attr_reader :errors

  def initialize(params)
    @errors = []
    if params.present?
      filter_to_permitted_parameters(params).tap do |permitted|
        validate_and_coerce_parameters(permitted).tap do |validated_and_coerced|
          @params = validated_and_coerced
          @errors << @params.errors unless @params.valid?
        end
      end
    end
  end

  def call
    @errors ||= []
    return self unless successful?

    process_service_request
    self
  end

  private

  def filter_to_permitted_parameters(params)
    params.permit(self.class.permitted_parameters)
  end

  def validate_and_coerce_parameters(parameters)
    self.class.parameter_class.new(parameters)
  end

  def process_service_request
  end

  def successful?
    !@errors.any?
  end

  def error(error)
    @errors << error
  end
end
