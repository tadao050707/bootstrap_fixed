class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]

  def index
    @categories = Category.includes(:user)
  end

  def new
    @category = Category.new
    # @categories = Category.includes(:user)
    @categories = current_user.categories.includes(:user)
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.valid?
      @category.save
      redirect_to new_category_path, notice: "「#{@category.cat_name}」を作成しました"
    else
      @categories = current_user.categories.includes(:user)
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      edirect_to new_category_path, notice: "「#{@category.cat_name}」に変更しました"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to new_category_path, notice: "「#{@category.cat_name}」を削除しました"
  end


  private
  def category_params
    params.require(:category).permit(:cat_name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
