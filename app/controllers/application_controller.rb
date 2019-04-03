class ApplicationController < ActionController::Base


  private
  def no_use_turbolinks_cache
    @use_turbolinks_cache = false
  end
end
