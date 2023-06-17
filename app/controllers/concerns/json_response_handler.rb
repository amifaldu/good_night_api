module JsonResponseHandler
  extend ActiveSupport::Concern

  included do
    ActionController::Parameters.action_on_unpermitted_parameters = :raise

    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from ActionController::UnpermittedParameters, with: :handle_unpermitted_parameters
  end

  private

  def success(message = nil, data = nil, status = :ok)
    render json: { message: message, data: data }, status: status
  end

  def error(errors = [], status = :unprocessable_entity)
    render json: { errors: errors }, status: status
  end

  def handle_not_found
    error([I18n.t('error.E0001')])
  end

  def handle_record_invalid(exception)
    error(exception.record.errors.full_messages)
  end

  def handle_parameter_missing(exception)
    error([exception.message], :bad_request)
  end

  def handle_unpermitted_parameters(exception)
    error([exception.message], :bad_request)
  end
end