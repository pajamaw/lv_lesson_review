class UsersController <ApplicationController
  before_filter :require_login
  
  def index
    @user = User.find_by(id: current_user.id)
    authorize @user
    @users = User.all
    #else
     # #flash[:alert] = "Not authorized"
      #redirect_to(request.referrer || root_path)
   # end
  end

  def show
    if User.find_by(id: params[:id])
      @user = User.find_by(id: params[:id])
      authorize @user
    else
      flash[:notice] = "User not found."
      redirect_to root_path  
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def update
  end 


  def destroy
    @user = User.find_by(id: current_user.id)
    authorize @user
    Rating.all.select{|rating| rating.user_id == @user.id}.each do |rating|
      rating.destroy
    end
    Comment.all.select{|comment| comment.user_id == @user.id}.each do |comment|
      comment.destroy
    end
    @user.destroy
    flash[:notice] = "Account deleted."
    redirect_to root_path
  end


end