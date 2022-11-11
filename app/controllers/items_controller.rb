class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :situation_id, :delivery_charge_id, :prefecture_id, :days_required_id, :price, :image, :user).merge(user_id: current_user.id)
  end
end
