class RegistrationsController < ApplicationController
  allow_unauthenticated_access # you can't be signed in before you sign up!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user # sign them in straight away
      redirect_to root_path, notice: "Welcome, #{@user.name}!"
    else
      render :new, status: :unprocessable_content
    end
  end

  private
    def user_params
      params.expect(user: [ :name, :email_address, :password, :password_confirmation ])
    end
end
