class UsersController < Clearance::UsersController


  def new
    @user = User.new
  end

  def show
    @all_users = User.all
  end

  def admin
    @all_users = User.all
  end

  def profile
    @user_profile = User.find(params[:id])
    @user_listing = Listing.where(user_id: params[:id])
    @user_id = User.find(current_user.id)
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

  def destroy
    @user = User.find(params[:id])
    @listing = Listing.where(user_id: params[:id])
    @listing.destroy_all
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :full_name, :role)
  end

end
