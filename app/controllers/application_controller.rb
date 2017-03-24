class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :add_allow_credentials_headers
    # [...]
    before_action :authenticate_user!
    include Pundit

  # Pundit: white-list approach.
  # after_action :verify_authorized, :except => :index, unless: :devise_controller?
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end


#   def add_allow_credentials_headers
#   # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5
#   # Because we want our front-end to send cookies to allow the API to be authenticated
#   # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so
#   # the browser will not reject the response
#     response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
#     response.headers['Access-Control-Allow-Credentials'] = 'true'
#   end

# def options
#   head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'
# end

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

end

