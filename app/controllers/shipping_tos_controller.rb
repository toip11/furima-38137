class ShippingTosController < ApplicationController
  before_action :item_find, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    @item = Item.find(params[:item_id])
    @shipping_to_purchase_record = PurchaseRecordShippingTo.new
  end

  def create
    @item = Item.find(params[:item_id])
    @shipping_to_purchase_record = PurchaseRecordShippingTo.new(shipping_to_params)
    if @shipping_to_purchase_record.valid?
      pay_item
      @shipping_to_purchase_record.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def shipping_to_params
    params.require(:purchase_record_shipping_to).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item[:price],
      card: shipping_to_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    return unless PurchaseRecord.exists?(item_id: @item.id)

    redirect_to controller: :items, action: :index
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
