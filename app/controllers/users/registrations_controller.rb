# frozen_string_literal: true
require "nkf"
class Users::RegistrationsController < Devise::RegistrationsController

  before_action :set_api_key, only: [:create]

  def registration
    session[:provider] = "registration"
    @user = User.new
    @detail = @user.build_user_detail
  end

  def google
    @user = User.new
    @user.nickname = session[:nickname]
    @user.email = session[:email]
    @detail = @user.build_user_detail
  end

  def sms_confirmation
      if session[:provider] == "registration"
        get_error_messages_registration
      elsif session[:provider] == "google_oauth2"
        get_error_messages_google
      end

      if @user.errors.messages.blank? && @detail.errors.messages.blank?
        if session[:provider] == "registration"
          set_registration_session
        elsif session[:provider] == "google_oauth2"
          set_google_session
        end
      else
        if session[:provider] == "registration"
          render :registration
        elsif session[:provider] == "google_oauth2"
          render :google
        end
      end

  end

  def address
    @detail = UserDetail.new

    if sms_params[:cell_phone_number].blank?
      @detail.errors[:cell_phone_number] << " 入力してください"
    elsif !!!(sms_params[:cell_phone_number] =~ /\A0[7-9]0-?\d{4}-?\d{4}\z/ || sms_params[:phone_number] =~ /\A0[7-9]0[0-9]{7,8}+\z/)
      @detail.errors[:cell_phone_number] << " フォーマットが不適切です"
    end

    if @detail.errors.messages.blank?
      @address = UserAddress.new
      session[:cell_phone_number] = sms_params[:cell_phone_number].delete("-")
      render :address
    else
      render :sms_confirmation
    end

  end

  def credit

    get_credit_error_message

    if @address.errors.messages.blank?
      @user = User.new
      set_credit_session
      render :credit
    else
      render :address
    end

  end

  def create

    get_create_error_message
    if @user.errors.messages.blank?

      customer = Payjp::Customer.create(card: card_params[:payjpToken])
      build_resource(email: session[:email], password: session[:password], nickname: session[:nickname],pay_id: customer.id)
      resource.save

      @detail = UserDetail.create(user_id: resource.id ,family_name: session[:family_name], given_name: session[:given_name], family_name_kana: session[:family_name_kana], given_name_kana: session[:given_name_kana], birth_year: session[:birth_year], birth_month: session[:birth_month], birth_day: session[:birth_day], cell_phone_number: session[:cell_phone_number])

      @address = UserAddress.create(user_id: resource.id, family_name: session[:address_family_name], given_name: session[:address_given_name], family_name_kana: session[:address_family_name_kana], given_name_kana: session[:address_given_name_kana], postal_code: session[:postal_code],prefecture_id: session[:prefecture_id], city: session[:city], block: session[:block],building: session[:building], phone_number: session[:phone_number])

      if session[:provider] == "google_oauth2"
        SnsCredential.create(user_id: resource.id, uid: session[:uid], provider: session[:provider])
      end

      sign_in(resource_name, resource)
      render :create
    else
      render :credit
    end

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
      elsif User.find_by(email: user_params[:email])
        @user.errors[:email] << "は既に使用されています"
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
      elsif !!!(half_to_kana(user_params[:user_detail_attributes][:family_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
        @detail.errors[:family_name_kana] << "はカナ文字を入力してください"
      else
        @detail.family_name_kana = half_to_kana(user_params[:user_detail_attributes][:family_name_kana])
      end

      if user_params[:user_detail_attributes][:given_name_kana].blank?
        @detail.errors[:given_name_kana] << "入力してください"
      elsif user_params[:user_detail_attributes][:given_name_kana].length > 35
        @detail.errors[:given_name_kana] << "は35文字までです"
      elsif !!!(half_to_kana(user_params[:user_detail_attributes][:given_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
        @detail.errors[:given_name_kana] << "はカナ文字を入力してください"
      else
        @detail.given_name_kana = half_to_kana(user_params[:user_detail_attributes][:given_name_kana])
      end

      if user_params[:user_detail_attributes][:birth_year].blank? || user_params[:user_detail_attributes][:birth_month].blank? || user_params[:user_detail_attributes][:birth_day].blank?
        @detail.errors[:birth] << "を入力してください"
      end
  end

  def get_error_messages_google
      @user = User.new
      @detail = @user.build_user_detail

      if google_params[:recaptcha].blank?
        @user.errors[:recaptcha] << " 選択してください"
      end

      if google_params[:nickname].blank?
        @user.errors[:nickname] << " 入力してください"
      elsif google_params[:nickname].length > 20
        @user.errors[:nickname] << " 20文字以下で入力してください"
        @user.nickname = google_params[:nickname]
      else
        @user.nickname = google_params[:nickname]
      end

      if google_params[:email].blank?
        resource.errors[:email] << " 入力してください"
      elsif !!!(google_params[:email] =~ /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/)
        @user.errors[:email] << " フォーマットが不適切です"
        @user.email = google_params[:email]
      elsif User.find_by(email: google_params[:email])
        @user.errors[:email] << "は既に使用されています"
        @user.email = google_params[:email]
      else
        @user.email = google_params[:email]
      end

      if google_params[:user_detail_attributes][:family_name].blank?
        @detail.errors[:family_name] << "入力してください"
      elsif google_params[:user_detail_attributes][:family_name].length > 35
        @detail.errors[:family_name] << "は35文字までです"
      else
        @detail.family_name = half_to_full(google_params[:user_detail_attributes][:family_name])
      end

      if google_params[:user_detail_attributes][:given_name].blank?
        @detail.errors[:given_name] << "を入力してください"
      elsif google_params[:user_detail_attributes][:given_name].length > 35
        @detail.errors[:given_name] << "は35文字までです"
      else
        @detail.given_name = half_to_full(google_params[:user_detail_attributes][:given_name])
      end

      if google_params[:user_detail_attributes][:family_name_kana].blank?
        @detail.errors[:family_name_kana] << "入力してください"
      elsif google_params[:user_detail_attributes][:family_name_kana].length > 35
        @detail.errors[:family_name_kana] << "は35文字までです"
      elsif !!!(half_to_kana(google_params[:user_detail_attributes][:family_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
        @detail.errors[:family_name_kana] << "はカナ文字を入力してください"
      else
        @detail.family_name_kana = half_to_kana(google_params[:user_detail_attributes][:family_name_kana])
      end

      if google_params[:user_detail_attributes][:given_name_kana].blank?
        @detail.errors[:given_name_kana] << "入力してください"
      elsif google_params[:user_detail_attributes][:given_name_kana].length > 35
        @detail.errors[:given_name_kana] << "は35文字までです"
      elsif !!!(half_to_kana(google_params[:user_detail_attributes][:given_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
        @detail.errors[:given_name_kana] << "はカナ文字を入力してください"
      else
        @detail.given_name_kana = half_to_kana(google_params[:user_detail_attributes][:given_name_kana])
      end

      if google_params[:user_detail_attributes][:birth_year].blank? || google_params[:user_detail_attributes][:birth_month].blank? || google_params[:user_detail_attributes][:birth_day].blank?
        @detail.errors[:birth] << "を入力してください"
      end
  end

  def get_credit_error_message
    @address = UserAddress.new

    if address_params[:family_name].blank?
      @address.errors[:family_name] << "入力してください"
    elsif address_params[:family_name].length > 35
      @address.errors[:family_name] << "は35文字までです"
    else
      @address.family_name = half_to_full(address_params[:family_name])
    end

    if address_params[:given_name].blank?
      @address.errors[:given_name] << "を入力してください"
    elsif address_params[:given_name].length > 35
      @address.errors[:given_name] << "は35文字までです"
    else
      @address.given_name = half_to_full(address_params[:given_name])
    end

    if address_params[:family_name_kana].blank?
      @address.errors[:family_name_kana] << "入力してください"
    elsif address_params[:family_name_kana].length > 35
      @address.errors[:family_name_kana] << "は35文字までです"
    elsif !!!(half_to_kana(address_params[:family_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
      @address.errors[:family_name_kana] << "はカナ文字を入力してください"
    else
      @address.family_name_kana = half_to_kana(address_params[:family_name_kana])
    end

    if address_params[:given_name_kana].blank?
      @address.errors[:given_name_kana] << "入力してください"
    elsif address_params[:given_name_kana].length > 35
      @address.errors[:given_name_kana] << "は35文字までです"
    elsif !!!(half_to_kana(address_params[:given_name_kana]) =~ /\A[ァ-ヾｦ-ﾟ]+\Z/)
      @address.errors[:given_name_kana] << "はカナ文字を入力してください"
    else
      @address.given_name_kana = half_to_kana(address_params[:given_name_kana])
    end

    if address_params[:postal_code].blank?
      @address.errors[:postal_code] << "入力してください"
    elsif !!!(address_params[:postal_code] =~ /\A[0-9]{3}-[0-9]{4}\z/ || address_params[:postal_code] =~ /\A[0-9]{7}+\z/)
      @address.errors[:postal_code] << "フォーマットが不適切です"
    else
      @address.postal_code = address_params[:postal_code]
    end

    if address_params[:prefecture_id].blank?
      @address.errors[:prefecture_id] << "入力してください"
    else
      @address.prefecture_id = address_params[:prefecture_id]
    end

    if address_params[:city].blank?
      @address.errors[:city] << "入力してください"
    elsif address_params[:city].length > 50
      @address.errors[:city] << "50文字以下で入力してください"
      @address.city = address_params[:city]
    else
      @address.city = address_params[:city]
    end

    if address_params[:block].blank?
      @address.errors[:block] << "入力してください"
    elsif address_params[:block].length > 50
      @address.errors[:block] << "50文字以下で入力してください"
      @address.block = address_params[:block]
    else
      @address.block = address_params[:block]
    end

    if address_params[:building].length > 50
      @address.errors[:building] << "50文字以下で入力してください"
      @address.building = address_params[:building]
    else
      @address.building = address_params[:building]
    end

    if !(address_params[:phone_number].blank?)
      if !!!(address_params[:phone_number] =~ /\A0[0-9]{9,10}\z/ || address_params[:phone_number] =~ /\A0[0-9]{2,3}-[0-9]{4}-[0-9]{4}\z/)
        @address.errors[:phone_number] << "フォーマットが不適切です"
        @address.phone_number = address_params[:phone_number].delete("-")
      else
        @address.phone_number = address_params[:phone_number].delete("-")
      end
    end

  end

  def get_create_error_message
    @user = User.new

    if card_params[:card_number].blank?
      @user.errors[:card_number] << "入力してください"
    elsif !!!(card_params[:card_number] =~ /\A[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}\z/)
      @user.errors[:card_number] << "半角数字で入力してください"
    else
      @user.card_number = card_params[:card_number]
    end

    if card_params[:credit_year].blank?
      @user.errors[:credit_year] << "入力してください"
    else
      @user.credit_year = card_params[:credit_year]
    end

    if card_params[:credit_month].blank?
      @user.errors[:credit_month] << "入力してください"
    else
      @user.credit_month = card_params[:credit_month]
    end

    if card_params[:card_code].blank?
      @user.errors[:card_code] << "必須項目です"
    elsif !!!(card_params[:card_code] =~ /\A[0-9]{3,4}\z/)
      @user.errors[:card_code] << "正しくありません"
    end

    if card_params[:payjpToken].blank?
      @user.errors[:total] << " このカードはご利用になれません。"
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, user_detail_attributes:[:family_name, :given_name, :family_name_kana, :given_name_kana,:birth_year, :birth_month, :birth_day]).merge(recaptcha: params[:"g-recaptcha-response"])
  end

  def google_params
    params.require(:user).permit(:nickname, :email, user_detail_attributes:[:family_name, :given_name, :family_name_kana, :given_name_kana,:birth_year, :birth_month, :birth_day]).merge(recaptcha: params[:"g-recaptcha-response"])
  end

  def sms_params
    params.require(:user_detail).permit(:cell_phone_number)
  end

  def address_params
    params.require(:user_address).permit(:family_name, :given_name, :family_name_kana, :given_name_kana, :postal_code, :prefecture_id, :city, :block, :building, :phone_number)
  end

  def card_params
    params.require(:user).permit(:card_number, :credit_year, :credit_month, :card_code).merge(payjpToken: params[:payjpToken])
  end

  def half_to_full(str)
    str = str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
    str = NKF.nkf("-Xw",str)
    return str
  end

  def half_to_kana(str)
    str = str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
    str = str.tr('ぁ-ん','ァ-ン')
    str = NKF.nkf("-Xw",str)
    return str
  end

  def set_registration_session
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:family_name] = half_to_full(user_params[:user_detail_attributes][:family_name])
    session[:given_name] = half_to_full(user_params[:user_detail_attributes][:given_name])
    session[:family_name_kana] = half_to_kana(user_params[:user_detail_attributes][:family_name_kana])
    session[:given_name_kana] = half_to_kana(user_params[:user_detail_attributes][:given_name_kana])
    session[:birth_year] = user_params[:user_detail_attributes][:birth_year]
    session[:birth_month] = user_params[:user_detail_attributes][:birth_month]
    session[:birth_day] = user_params[:user_detail_attributes][:birth_day]
  end

  def set_credit_session
    session[:address_family_name] = half_to_full(address_params[:family_name])
    session[:address_given_name] = half_to_full(address_params[:given_name])
    session[:address_family_name_kana] = half_to_kana(address_params[:family_name_kana])
    session[:address_given_name_kana] = half_to_kana(address_params[:given_name_kana])
    session[:postal_code] = address_params[:postal_code]
    session[:prefecture_id] = address_params[:prefecture_id]
    session[:city] = address_params[:city]
    session[:block] = address_params[:block]
    session[:building] = address_params[:building]
    session[:phone_number] = address_params[:phone_number].delete("-")
  end

  def set_google_session
    session[:nickname] = google_params[:nickname]
    session[:email] = google_params[:email]
    session[:family_name] = half_to_full(google_params[:user_detail_attributes][:family_name])
    session[:given_name] = half_to_full(google_params[:user_detail_attributes][:given_name])
    session[:family_name_kana] = half_to_kana(google_params[:user_detail_attributes][:family_name_kana])
    session[:given_name_kana] = half_to_kana(google_params[:user_detail_attributes][:given_name_kana])
    session[:birth_year] = google_params[:user_detail_attributes][:birth_year]
    session[:birth_month] = google_params[:user_detail_attributes][:birth_month]
    session[:birth_day] = google_params[:user_detail_attributes][:birth_day]
  end

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def set_api_key
    Payjp.api_key = 'sk_test_cf22f826afb6315d068a24b2'
  end

end


