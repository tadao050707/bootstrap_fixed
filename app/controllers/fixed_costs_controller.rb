class FixedCostsController < ApplicationController
  before_action :set_fixed_cost, only: %i[show edit update destroy]

  def index
    @fixed_costs = FixedCost.includes(:user)
  end

  def new
    @fixed_cost = FixedCost.new
    @categories = Category.all
  end

  def create
    @fixed_cost = current_user.fixed_costs.build(fixed_cost_params)
    if @fixed_cost.save
      redirect_to fixed_cost_path(@fixed_cost), notice: "「」登録しました"
    else
      @categories = Category.all

      render :new
    end
  end

  def edit
  end

  def show
  end


  private
  def fixed_cost_params
    params.require(:fixed_cost).permit(:payment, :content, :monthly_annual, :category_ids, :user_id)
  end

  def set_fixed_cost
    @fixed_cost = current_user.fixed_costs.find(params[:id])
  end

  def login_check
    unless user_signed_in?
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end
end
