class ApplicationController < ActionController::Base
  before_action :log_activity

  def require_admin
    redirect_to root_path, alert: "Недостатньо прав" unless user_signed_in? && current_user.admin?
  end

  private

  def log_activity
    # avoid logging asset requests and health checks
    return if request.path.start_with?('/assets') || request.path.match?(/rails\/pwa|service-worker|manifest|up/)
    begin
      filtered = filtered_activity_params
      ActivityLog.create(
        user: (current_user if defined?(current_user)),
        path: request.path,
        http_method: request.request_method,
        params: filtered.to_json,
        ip: request.remote_ip,
        user_agent: request.user_agent
      )
    rescue => e
      Rails.logger.info "ActivityLog error: #{e.message}"
    end
  end

  def filtered_activity_params
    # avoid storing sensitive fields
    p = request.filtered_parameters.dup
    %w[controller action authenticity_token commit utf8 password password_confirmation].each { |k| p.delete(k) }
    p
  end
end
