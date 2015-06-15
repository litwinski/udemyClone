class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :facebook, :twitter, :github, :portfolio)
  end

  def update_resource(resource, params)
    if current_user.provider == "facebook" || current_user.provider == "google_oauth2" || current_user.provider == "github"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

end