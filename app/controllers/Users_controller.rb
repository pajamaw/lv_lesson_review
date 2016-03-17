class UsersController <ApplicationController
    # Prevent CSRF attacks by raising an exception.

  def index
    if logged_in? && current_user.deity?
      @users = User.all
    else
      flash[:alert] = "Not authorized"
      redirect_to(request.referrer || root_path)
    end
  end

  def show
    if logged_in?
      @user = User.find_by(id: params[:id])
    else
     flash[:alert] = "Not authorized"
     redirect_to(request.referrer || root_path)
   end

  end

  def destroy
    @user = User.find_by(id: params[:id])
    if logged_in? && (current_user.deity? || @user == current_user)
      Rating.all.select{|rating| rating.user_id == @user.id}.each do |rating|
        rating.destroy
      end
      Comment.all.select{|comment| comment.user_id == @user.id}.each do |comment|
        comment.destroy
      end
      @user.destroy
      flash[:notice] = "Account deleted."
      redirect_to root_path
    else
      flash[:alert] = "You must log in to delete your account"
      redirect_to(request.referrer || root_path)
    end
  end


end