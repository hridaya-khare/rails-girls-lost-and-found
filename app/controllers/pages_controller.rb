class PagesController < ApplicationController
  allow_unauthenticated_access

  def home
    redirect_to root_path
  end
end
