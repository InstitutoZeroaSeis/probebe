class ApplicationController < ActionController::Base
  impersonates :user
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng

  before_action :utm_source

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to carnival_root_path, alert: exception.message
  end

  def user_for_paper_trail
    current_user.email if user_signed_in?
  end

  def current_profile
    current_user.profile if current_user
  end
  helper_method :current_profile

  def deny_site_user_access_on_admin
    return if current_user && !current_user.site_user?
    redirect_to root_path
  end

protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

private

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.site_user?
      root_path
    else
      carnival_root_path
    end
  end

  def utm_source
    source = get_source
    session[:utm_source] = source if source.present?
  end

  def get_source
    return params[:utm_source] if params[:utm_source].present?
    if request.referer.present?
      return request.referer if URI(request.referer).host != request.host
    end
    ''
  end
end
