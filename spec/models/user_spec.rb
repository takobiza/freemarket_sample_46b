require 'rails_helper'
describe User do
    describe 'ユーザー作成' do
      describe 'ユーザー作成成功' do

        it '正常に作成' do
          user = build(:user)
          expect(user).to be_valid
        end

        it "パスワードが6文字" do
          user = build(:user, password: "0"*6, password_confirmation: "0"*6 )
          expect(user).to be_valid
        end

        it "パスワードが128文字" do
          user = build(:user, password: "0"*128, password_confirmation: "0"*128 )
          expect(user).to be_valid
        end

      end


    describe 'ユーザー作成エラー' do

      describe 'メールアドレスエラー' do

        it 'メールアドレスが空白はエラー' do
          user = build(:user,email: nil)
          user.valid?
          expect(user.errors[:email]).to include("が入力されていません。")
        end

        it 'メールアドレスはユニーク' do
          user = create(:user)
          another_user = build(:user, email: user.email)
          another_user.valid?
          expect(another_user.errors[:email]).to include("は既に使用されています。")
        end

        it 'メールアドレスのフォーマットが正しくないとエラー' do
          user = create(:user)
          another_user = build(:user, email: "testaddress")
          another_user.valid?
          expect(another_user.errors[:email]).to include("のフォーマットが不適切です")
        end

      end

      describe 'メールアドレスエラー' do

        it 'パスワードが空白の時入力されていませんエラーになる' do
          user = build(:user,password: nil)
          user.valid?
          expect(user.errors[:password]).to include("が入力されていません。")
        end

        it 'パスワードが空白の時文字数エラーも表示される' do
          user = build(:user,password: nil)
          user.valid?
          expect(user.errors[:password]).to include("は6文字以上128文字以下で入力してください")
        end

        it 'パスワードと確認のパスワードが一致しないとエラー' do
          user = build(:user,password_confirmation: "")
          user.valid?
          expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
        end

        it "パスワードが5文字はエラー" do
          user = build(:user, password: "00000")
          user.valid?
          expect(user.errors[:password][0]).to include("は6文字以上128文字以下で入力してください")
        end

        it "パスワードが129文字はエラー" do
          user = build(:user, password: "0"*129)
          user.valid?
          expect(user.errors[:password][0]).to include("は6文字以上128文字以下で入力してください")
        end

      end

    end
  end
end

