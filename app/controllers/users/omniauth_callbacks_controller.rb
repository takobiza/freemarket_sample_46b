# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_from :google
  end

  private

  def callback_from(provider)
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @sns = SnsCredential.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first

      if @sns
        sign_in_and_redirect @sns.user, event: :authentication
      else
          session[:nickname] = @omniauth['info']['name']
          session[:email] = @omniauth['info']['email']
          session[:password] = Devise.friendly_token[0, 20]
          session[:provider] = @omniauth['provider']
          session[:uid] = @omniauth['uid']
          redirect_to signup_google_path
      end
    end
  end

end
