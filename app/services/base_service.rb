class BaseService
  include Callable

  attr_reader :errors

  def self.check_parameters(params)
    if self.respond_to?(:required_parameters) &&
       self.respond_to?(:permitted_parameters)
      return params.permit(*permitted_parameters).tap do |parameter|
        parameter.require(required_parameters)
      end
    end
  end

  def call
    @errors ||= []

    validate
    return self unless successful?

    process_service_request
    self
  end

  private

  def validate
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
