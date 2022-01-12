class FixedCostsController < ApplicationController
  before_action :authenticate_user!, except: [:all_costs]
  before_action :set_fixed_cost, only: %i[ edit update destroy ]

  def index
    # @costs = FixedCost.group(:user_id).sum(:payment)

    ＠users = User.includes(:fixed_costs)
    # @fixed_costs = FixedCost.includes(:user)
    # @fixed_costs = users.fixed_costs.includes(:user)
    total_annual = []
    total_monthly = []
    @users.each do |user|
      user.fixed_costs.each do |fixed_cost|
        if fixed_cost.monthly_annual == annual
          total_annual << fixed_cost.payment
          total_monthly << monthly_payment(fixed_cost.payment)
        elsif fixed_cost.monthly_annual == monthly
          total_annual << annual_payment(fixed_cost.payment)
          total_monthly << fixed_cost.payment
        end

      end

    end
    @total_annual_costs = total_annual.sum
    @total_monthly_costs = total_monthly.sum


  end
  #
  #   if params[:monthly_view].nil?
  #     @monthly_view = "true"
  #   else
  #     @monthly_view = params[:monthly_view]
  #   end
  #
  #   # -----monthly_annualの金額を月額に直して、合計して、出力する
  #   total_annual = []
  #   total_monthly = []
  #   @fixed_costs.each do |fixed_cost|
  #     if @monthly_view == "true" && fixed_cost.monthly_annual == "annual"
  #       total_monthly << fixed_cost.payment / 12
  #     elsif @monthly_view == "true" && fixed_cost.monthly_annual == "monthly"
  #       total_monthly << fixed_cost.payment
  #     elsif @monthly_view == "false" && fixed_cost.monthly_annual == "monthly"
  #       total_annual << fixed_cost.payment * 12
  #     else
  #       total_annual << fixed_cost.payment
  #     end
  #   end
  #   @total_monthly_costs = total_monthly.sum
  #   @total_annual_costs = total_annual.sum
  #

  def show
    # redirect_to fixed_costs_path if @fixed_cost.blank?
    user = User.find_by(id: params[:id])
    # user = User.find(params[:id])
    @fixed_costs = user.fixed_costs.includes(:user)

    if params[:monthly_view].nil?
      @monthly_view = "true"
    else
      @monthly_view = params[:monthly_view]
    end

    # -----monthly_annualの金額を月額に直して、合計して、出力する
    total_annual = []
    total_monthly = []
    @fixed_costs.each do |fixed_cost|
      if @monthly_view == "true" && fixed_cost.monthly_annual == "annual"
        # total_monthly << fixed_cost.payment / 12
        total_monthly << monthly_payment(fixed_cost)
      elsif @monthly_view == "true" && fixed_cost.monthly_annual == "monthly"
        total_monthly << fixed_cost.payment
      elsif @monthly_view == "false" && fixed_cost.monthly_annual == "monthly"
        # total_annual << fixed_cost.payment * 12
        total_annual << annual_payment(fixed_cost)
      else
        total_annual << fixed_cost.payment
      end
    end
    @total_monthly_costs = total_monthly.sum
    @total_annual_costs = total_annual.sum

  end

  def new
    @fixed_cost = FixedCost.new
    @categories = current_user.categories.includes(:user)
  end

  def create
    @fixed_cost = current_user.fixed_costs.build(fixed_cost_params)
    if @fixed_cost.save
      redirect_to fixed_cost_path(current_user), notice: "新しく「#{@fixed_cost}」を登録しました"
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
    redirect_to fixed_cost_path(current_user), notice: "変更しました"
    render :edit if @fixed_cost.invalid?
  end

  def destroy
    if @fixed_cost.destroy
      flash[:success] = '削除しました。'
      redirect_to fixed_cost_path(current_user)
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
