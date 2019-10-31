class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    :new_profile
  end
end