# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    if flash[:error].present?
      resource.errors[:total] << flash[:error]
    end
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  def create
    if verify_recaptcha

      if self.resource = warden.authenticate(auth_options)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        self.resource = get_error_messages
        respond_with_navigational(resource) { render :new }
      end

    else
      self.resource = get_error_messages
      respond_with_navigational(resource) { render :new }
    end
  end

  protected

  def get_error_messages
      resource = resource_class.new

      if user_params[:email].blank?
        resource.errors[:email] << " 入力してください"
      elsif !!!(user_params[:email] =~ /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/)
        resource.errors[:email] << " フォーマットが不適切です"
        resource.email << user_params[:email]
      else
        resource.email << user_params[:email]
      end

      if user_params[:password].blank?
        resource.errors[:password] << " 入力してください"
      elsif user_params[:password].length < 6 || user_params[:password].length > 128
        resource.errors[:password] << " 6文字以上128文字以下で入力してください"
      end

      if user_params[:recaptcha].blank?
        resource.errors[:recaptcha] << " 選択してください"
      end

      if resource.errors.messages.blank?
        resource.errors[:total] << " メールアドレスまたはパスワードが違います"
      end

      return resource
  end

  def user_params
    params.require(:user).permit(:email, :password).merge(recaptcha: params[:"g-recaptcha-response"])
  end

end
