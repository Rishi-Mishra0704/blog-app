class Users::SessionsController < Devise::SessionsController
  # Redirect to a custom path after sign in
  def after_sign_in_path_for(resource)
    # Customize the path according to your application
    root_path
  end
end
