class FixedCostsController < ApplicationController
  before_action :authenticate_user!, except: [:all_costs]
  before_action :set_fixed_cost, only: %i[ edit update destroy ]

  def index
    # @fixed_costs = current_user.fixed_costs.includes(:user)
    # @total_costs = @fixed_costs.sum(:payment)
    # @monthly_view = false
    # @monthly_view = params[:monthly_view] if params[:monthly_view].present?

    @users = User.all
    @fixed_costs = FixedCost.includes(:user)
    @costs = FixedCost.group(:user_id).sum(:payment)
  end

  def show
    # redirect_to fixed_costs_path if @fixed_cost.blank?
    user = User.find_by(id: params[:id])
    @fixed_costs = user.fixed_costs.includes(:user)
    @total_costs = @fixed_costs.sum(:payment)
    # @monthly_view = true
    # binding.irb
    if params[:monthly_view].nil?
      @monthly_view = "true"
    else
      @monthly_view = params[:monthly_view]
    end
  end

  def new
    @fixed_cost = FixedCost.new
    @categories = current_user.categories.includes(:user)
  end

  def create
    @fixed_cost = current_user.fixed_costs.build(fixed_cost_params)
    if @fixed_cost.save
      redirect_to fixed_costs_path, notice: "「」登録しました"
    else
      @categories = current_user.categories.includes(:user)
      render :new
    end
  end

  def edit
    @categories = current_user.categories.includes(:user)
  end

  def update
    @fixed_cost.update(fixed_cost_params)
    redirect_to fixed_costs_path, notice: "変更しました"
    render :edit if @fixed_cost.invalid?
  end

  def destroy
    if @fixed_cost.destroy
      flash[:success] = '削除しました。'
      redirect_to fixed_costs_path
    else
      flash[:danger] = '削除に失敗しました。'
      redirect_to user_path(current_user)
    end
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
