class FixedCostsController < ApplicationController
  before_action :set_fixed_cost, only: %i[show edit update destroy]

  def index
    @fixed_costs = FixedCost.all
  end

  def new
    @fixed_cost = FixedCost.new
  end

  def create
    @fixed_cost = current_user.fixed_costs.build(fixed_costs_params)
    if @fixed_cost.save
      redirect_to fixed_cost_path(fixed_cost.id), notice: "「」登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def show
  end


  private
  def fixed_costs_params
    params.require(:fixed_costs).permit(:payment, :content, :monthly_annual, :user_id, :category_ids)
  end

  def set_fixed_cost
    @fixed_cost = current_user.fixed_costs.find(params[:id])
  end
end
