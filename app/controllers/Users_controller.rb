class UsersController <ApplicationController
  before_filter :require_login
  
  def index
    @user = User.find_by(id: current_user.id)
    authorize @user
    @users = User.all
  end

  def show
    if User.find_by(id: params[:id])
      @user = User.find(params[:id])
      authorize @user
    else
      flash[:alert] = "User not found."
      redirect_to root_path  
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def promote
    @user = User.find_by(id: params[:id])
    authorize @user
    @user.role = params[:role]
    @user.save
    flash[:notice] = "User status updated."
    redirect_to user_path
  end 

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    flash[:notice] = "Account deleted."
    redirect_to root_path
  end


end