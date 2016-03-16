class WelcomeController <ApplicationController
  def home
    if !!current_user
      @categories = Category.all
      redirect_to categories_path
    end
  end
end