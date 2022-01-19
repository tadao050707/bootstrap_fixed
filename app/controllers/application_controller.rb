class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def monthly_payment(pey)
    pey.payment/12
  end

  def annual_payment(pey)
    pey.payment*12
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: %i[ name profile image image_cache adult_number child_number])
  end
end
