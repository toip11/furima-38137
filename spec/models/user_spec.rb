require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailが一意性でなければ登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailに@が存在しなければ登録できない' do
      @user.email = 'test.test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが6文字上でないと登録できない' do
      @user.password = '111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが数字のみでは登録できない' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'passwordが英字のみでは登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'passwordに全角英数字が含まれると登録できない' do
      @user.password = 'ｔｅｓｔ１１１１'
      @user.password_confirmation = 'ｔｅｓｔ１１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'passwordとpassword_confirmationが一致しなければ登録できない' do
      @user.password_confirmation = 'test1111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'お名前の苗字と名前が空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'お名前の名前と名前が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'お名前の苗字は全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
      @user.last_name = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end
    it 'お名前の名前は全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
      @user.first_name = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end
    it 'お名前の苗字のかなが空では登録できない' do
      @user.last_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading can't be blank")
    end
    it 'お名前の名前のかなが空では登録できない' do
      @user.first_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading can't be blank")
    end
    it 'お名前の苗字のカナが全角全角（カタカナ）でなければ登録できない' do
      @user.last_name_reading = '苗字'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid')
    end
    it 'お名前の名前のカナが全角全角（カタカナ）でなければ登録できない' do
      @user.first_name_reading = '名前'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid')
    end
    it '生年月日が空では登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
