class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def hardest_category
    @category = Category.hardest_category
    render template: 'categories/show'
  end
end
