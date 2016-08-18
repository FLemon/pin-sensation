class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  private

  def after_sign_out_path_ofr(resource_or_scope)
    chatrooms_path
  end
end
