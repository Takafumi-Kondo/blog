require 'rails_helper'

RSpec.describe User, type: :model do
  context "バリデーション" do
    it "名前とメールアドレスとパスワードがあれば登録できる" do
      expect(FactoryBot.create(:user)).to be_valid
    end

    it "nameがなければ登録できない" do
      expect(FactoryBot.build(:user, name: "")).to_not be_valid
    end
    it 'nameが16文字以上は登録できない' do
      expect(FactoryBot.build(:user, :too_long_name)).to_not be_valid
    end
    it 'nameが１文字以下は登録できない' do
      expect(FactoryBot.build(:user, :too_short_name)).to_not be_valid
    end

    it "emailがなければ登録できない" do
      expect(FactoryBot.build(:user, email: "")).to_not be_valid
    end
    it "emailが８１文字以上は登録できない" do
      expect(FactoryBot.build(:user, :too_long_email)).to_not be_valid
    end
    it "emailが重複していたら登録できない" do
      user1 = FactoryBot.create(:user,name: "ユーザー１", email: "user1@example.com")
      expect(FactoryBot.build(:user, name: "ユーザー２", email: user1.email)).to_not be_valid
    end

    it "introductionが１５１文字以上だと登録できない" do
      expect(FactoryBot.build(:user, :too_long_introduction)).to_not be_valid
    end

    it "passwordがなければ登録できない" do
      expect(FactoryBot.build(:user, password: "")).to_not be_valid
    end
    it "password_confirmationとpasswordが異なる場合保存できない" do 
      expect(FactoryBot.build(:user,password:"password",password_confirmation: "passward")).to_not be_valid 
    end
  end
end