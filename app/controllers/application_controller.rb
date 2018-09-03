class ApplicationController < ActionController::API
	rescue_from ActionController::ParameterMissing,
		with: :required_parameter_missing

	def required_parameter_missing(exception)
		render json: { error: exception }, status: :unprocessable_entity
	end
end
