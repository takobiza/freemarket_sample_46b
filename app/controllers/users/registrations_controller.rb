# frozen_string_literal: true
require "nkf"
class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def registration
    @user = User.new
    @detail = @user.build_user_detail
  end

  # def address
  #   # binding.pry

  #   if verify_recaptcha
  #     get_error_messages
  #     binding.pry

  #     if @user.errors.messages.blank? && @detail.errors.messages.blank?
  #       set_registration_session
  #     end

  #     render :registration
  #   else

  #     get_error_messages
  #     render :registration

  #   end

  # end

  def sms_confirmation
    @user = User.new
    @detail = @user.build_user_detail
    # if verify_recaptcha
    #   get_error_messages_registration

    #   if @user.errors.messages.blank? && @detail.errors.messages.blank?
        set_registration_session
    #   else
    #     render :registration
    #   end


    # else

    #   get_error_messages
    #   render :registration

    # end
  end

  def address
    # binding.pry
    @address = UserAddress.new
  end

  def credit
    @user = User.new
  end

  def create
    # if verify_recaptcha
    #   resource = resource_class.new
    #   @user = User.new
    #   binding.pry
    # else
    #   @user = User.new
    #   # resource = resource_class.new
    #   @user.errors[:recaptcha] << " 選択してください"
    #   if user_params[:nickname].blank?
    #     @user.errors[:nickname] << " 入力してください"
    #   elsif user_params[:nickname].length > 20
    #     @user.errors[:nickname] << " 20文字以下で入力してください"
    #     params[:session][:nickname] << user_params[:nickname]
    #   else
    #     @user.nickname = user_params[:nickname]
    #   end
    #   # binding.pry
    #   render :new
    # end
  end

  protected

  def get_error_messages_registration
      @user = User.new
      @detail = @user.build_user_detail

      if user_params[:recaptcha].blank?
        @user.errors[:recaptcha] << " 選択してください"
      end

      if user_params[:nickname].blank?
        @user.errors[:nickname] << " 入力してください"
      elsif user_params[:nickname].length > 20
        @user.errors[:nickname] << " 20文字以下で入力してください"
        @user.nickname = user_params[:nickname]
      else
        @user.nickname = user_params[:nickname]
      end

      if user_params[:email].blank?
        resource.errors[:email] << " 入力してください"
      elsif !!!(user_params[:email] =~ /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/)
        @user.errors[:email] << " フォーマットが不適切です"
        @user.email = user_params[:email]
      else
        @user.email = user_params[:email]
      end

      if user_params[:password].blank?
        @user.errors[:password] << "入力してください"
      elsif user_params[:password].length < 6 || user_params[:password].length > 128
        @user.errors[:password] << "6文字以上128文字以下で入力してください"
      end

      if user_params[:password_confirmation].blank?
        @user.errors[:password_confirmation] << "入力してください"
      elsif user_params[:password] != user_params[:password_confirmation]
        @user.errors[:password_confirmation] << "とパスワードが一致しません"
      end

      if user_params[:user_detail_attributes][:family_name].blank?
        @detail.errors[:family_name] << "入力してください"
      elsif user_params[:user_detail_attributes][:family_name].length > 35
        @detail.errors[:family_name] << "は35文字までです"
      else
        @detail.family_name = half_to_full(user_params[:user_detail_attributes][:family_name])
      end

      if user_params[:user_detail_attributes][:given_name].blank?
        @detail.errors[:given_name] << "を入力してください"
      elsif user_params[:user_detail_attributes][:given_name].length > 35
        @detail.errors[:given_name] << "は35文字までです"
      else
        @detail.given_name = half_to_full(user_params[:user_detail_attributes][:given_name])
      end

      if user_params[:user_detail_attributes][:family_name_kana].blank?
        @detail.errors[:family_name_kana] << "入力してください"
      elsif user_params[:user_detail_attributes][:family_name_kana].length > 35
        @detail.errors[:family_name_kana] << "は35文字までです"
      elsif !!!(half_to_full(user_params[:user_detail_attributes][:family_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
        @detail.errors[:family_name_kana] << "はカナ文字を入力してください"
      else
        @detail.family_name_kana = half_to_full(user_params[:user_detail_attributes][:family_name_kana])
      end

      if user_params[:user_detail_attributes][:given_name_kana].blank?
        @detail.errors[:given_name_kana] << "入力してください"
      elsif user_params[:user_detail_attributes][:given_name_kana].length > 35
        @detail.errors[:given_name_kana] << "は35文字までです"
      elsif !!!(half_to_full(user_params[:user_detail_attributes][:given_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
        @detail.errors[:given_name_kana] << "はカナ文字を入力してください"
      else
        @detail.given_name_kana = half_to_full(user_params[:user_detail_attributes][:given_name_kana])
      end

      if user_params[:user_detail_attributes][:birth_year].blank? || user_params[:user_detail_attributes][:birth_month].blank? || user_params[:user_detail_attributes][:birth_day].blank?
        @detail.errors[:birth] << "を入力してください"
      end
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, user_detail_attributes:[:family_name, :given_name, :family_name_kana, :given_name_kana,:birth_year, :birth_month, :birth_day]).merge(recaptcha: params[:"g-recaptcha-response"])
  end

  def half_to_full(str)
    str = str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
    str = str.tr('ぁ-ん','ァ-ン')
    str = NKF.nkf("-Xw",str)
    return str
  end

  def set_registration_session
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:family_name] = user_params[:family_name]
    session[:given_name] = user_params[:given_name]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:given_name_kana] = user_params[:given_name_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
  end

end


