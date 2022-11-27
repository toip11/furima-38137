class ShippingTosController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @shippings_to_purchase_record = PurchaseRecordShippingTo.new(shipping_to_params)
    if @shippings_to_purchase_record.valid?
      @shippings_to_purchase_record.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def shipping_to_params
    params.permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
