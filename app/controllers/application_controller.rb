class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV["BASIC_AUTH_USER"], :password => ENV["BASIC_AUTH_PASSWORD"], if: :production?



  private
  def no_use_turbolinks_cache
    @use_turbolinks_cache = false
  end

  def production?
    Rails.env.production?
  end

end
