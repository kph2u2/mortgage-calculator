class BaseService
  include Callable

  attr_reader :errors

  def call
    @errors ||= []

    validate
    return self unless valid?

    process_service_request
    self
  end

  private

  def validate
  end

  def process_service_request
  end

  def valid?
    !@errors.any?
  end

  def error(error)
    @errors << error
  end
end
