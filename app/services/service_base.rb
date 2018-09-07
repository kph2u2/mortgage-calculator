class ServiceBase
  include Callable

  attr_reader :errors

  def call
    validate
    return self unless valid?

    process_service_request
    self
  end

  private

  def valid?
    !@errors.any?
  end

  def error(error)
    @errors << error
  end
end
