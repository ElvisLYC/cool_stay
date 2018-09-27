class UsersController < Clearance::UsersController
  def example
  end

  def index
    @user_profile = User.find(params[:id])
    @user_listing = Listing.where(user_id: params[:id])
    @user_id = User.find(current_user.id)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @user_id = User.find(current_user.id)
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
    @customer_bookings = Reservation.where(user_id: params[:id])

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

  def update

    @user_id = User.find(current_user.id)
    @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to root_path
      else
        render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @listing = Listing.where(user_id: params[:id])
    @listing.destroy_all
    @user.destroy
    redirect_to root_path
  end

  def delete_avatar
    @user_profile = User.find(params[:id])
    @user_profile.remove_avatar!
    @user_profile.save
    # @user_profile.remove_avatar!
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :full_name, :role, :avatar, :gender, :phone, :country, :birthdate)
  end

end
