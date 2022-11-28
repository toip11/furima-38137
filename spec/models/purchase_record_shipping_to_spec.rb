require 'rails_helper'

RSpec.describe ShippingTo, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_record_shipping_to = FactoryBot.build(:purchase_record_shipping_to, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it '必要な情報を適切に入力して購入ボタンを押すと商品が購入できること' do
        expect(@purchase_record_shipping_to).to be_valid
      end
      it '建物名はからでも保存できること' do
        @purchase_record_shipping_to.building_name = ''
        expect(@purchase_record_shipping_to).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空では購入できないこと' do
        @purchase_record_shipping_to.postal_code = ''
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_record_shipping_to.postal_code = '1234567'
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @purchase_record_shipping_to.prefecture_id = ''
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include('Prefecture is not a number')
      end
      it 'prefectureが「---」では保存できない' do
        @purchase_record_shipping_to.prefecture_id = 1
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'municipalityが空では購入できないこと' do
        @purchase_record_shipping_to.municipality = ''
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空では購入できない' do
        @purchase_record_shipping_to.address = ''
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @purchase_record_shipping_to.phone_number = ''
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁未満では購入できない' do
        @purchase_record_shipping_to.phone_number = '1'
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end
      it 'phone_numberが11桁以上では購入できない' do
        @purchase_record_shipping_to.phone_number = '12345678901234567890'
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      it 'tokenが空では購入できない' do
        @purchase_record_shipping_to.token = ''
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("Token can't be blank")
      end
      it 'ユーザー情報が空では保存できない' do
        @purchase_record_shipping_to.user_id = nil
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("User can't be blank")
      end
      it '商品情報が空では保存できない' do
        @purchase_record_shipping_to.item_id = nil
        @purchase_record_shipping_to.valid?
        expect(@purchase_record_shipping_to.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
