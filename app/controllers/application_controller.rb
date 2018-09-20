class ApplicationController < ActionController::Base
  # include Clearance::Controller

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
end

private
  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
