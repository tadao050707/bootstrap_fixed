class FixedCostsController < ApplicationController
  before_action :authenticate_user!, except: [:all_costs]
  before_action :set_fixed_cost, only: %i[ edit update destroy ]

  def index
    @users = User.includes(:fixed_costs)
  end

  def show
    @user = User.find(params[:id])
    @fixed_costs = @user.fixed_costs.includes(:user)

    if params[:monthly_view].nil?
      @monthly_view = "true"
    else
      @monthly_view = params[:monthly_view]
    end

    # @costs = @fixed_costs.joins(:categories).group("categories.cat_name").sum(:payment).sort_by { |_, v| v }.reverse.to_h

    # 月額の支出だけまとめる（１）
    # all_monthlies = @fixed_costs.joins(:categories).where("monthly_annual = ?", 0).group("categories.cat_name").sum(:payment)
    all_monthlies = @fixed_costs.joins(:categories).where(monthly_annual: 0).group("categories.cat_name").sum(:payment)
    # 年額の支出だけまとめる（２）
    all_annuals = @fixed_costs.joins(:categories).where("monthly_annual = ?", 1).group("categories.cat_name").sum(:payment)
    # ここまで共通部分

    # 月額表示の場合
    # （２）を月額に変換
    if @monthly_view == "true"
      all_annuals = all_annuals.map{|key, value| [key, value/12]}.to_h
      # （１）と（２）を合計し、月額として@costsに代入
      @costs = all_monthlies.merge(all_annuals){|key, v1, v2| v1 + v2}.sort_by { |_, v| v }.reverse
    else
    # 年額表示の場合
      # （１）を年額に変換
      # all_annuals = all_annuals.map{|key, value| [key, value*12]}.to_h
      all_monthlies = all_monthlies.map{|key, value| [key, value*12]}.to_h

      # （１）と（２）を合計し、月額として@costsに代入
      # binding.pry
      @costs = all_monthlies.merge(all_annuals){|key, v1, v2| v1 + v2}.sort_by { |_, v| v }.reverse
      # binding.pry
    end


    @total_annual = []
    @total_monthly = []
    @fixed_costs.each do |fixed_cost|
      if @monthly_view == "true" && fixed_cost.monthly_annual == "annual"
        @total_monthly << monthly_payment(fixed_cost)
      elsif @monthly_view == "true" && fixed_cost.monthly_annual == "monthly"
        @total_monthly << fixed_cost.payment
      elsif @monthly_view == "false" && fixed_cost.monthly_annual == "monthly"
        @total_annual << annual_payment(fixed_cost)
      else
        @total_annual << fixed_cost.payment
      end
    end
  end

  def new
    @fixed_cost = FixedCost.new
    @categories = current_user.categories.includes(:user)
  end

  def create
    @fixed_cost = current_user.fixed_costs.build(fixed_cost_params)
    if @fixed_cost.save
      # binding.pry
      redirect_to fixed_cost_path(current_user), notice: "新しく「#{@fixed_cost.categories.map(&:cat_name).first}」を登録しました"
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
