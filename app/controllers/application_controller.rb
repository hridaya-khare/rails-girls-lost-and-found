class ApplicationController < ActionController::Base
  include Authentication
  # Load the signed-in user on public pages too, so views can use Current.user
  before_action :resume_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
