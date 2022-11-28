class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find, only: [:show, :edit, :update]
  before_action :move_to_index, only: :edit

  def index
    @items = Item.includes(:user).order('created_at DESC')
    @puchase_record = PurchaseRecord.all
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.user_id == current_user.id
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :situation_id, :delivery_charge_id, :prefecture_id,
                                 :days_required_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in? && current_user.id == @item.user_id

    redirect_to action: :index
  end

  def item_find
    @item = Item.find(params[:id])
  end
end
