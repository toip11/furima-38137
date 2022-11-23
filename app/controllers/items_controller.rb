class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(params[:id])
    @delivery_charge = DeliveryCharge.find(@item.delivery_charge_id)
    @category = Category.find(@item.category_id)
    @days_required = DaysRequired.find(@item.days_required_id)
    @prefecture = Prefecture.find(@item.prefecture_id)
    @situation = Situation.find(@item.situation_id)
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :situation_id, :delivery_charge_id, :prefecture_id, :days_required_id, :price, :image).merge(user_id: current_user.id)
  end
end
