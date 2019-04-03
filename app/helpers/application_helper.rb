module ApplicationHelper
  def use_turbolinks_cache?
    if @use_turbolinks_cache === false
      "no-cache"
    else
      "no-preview"
    end
  end
end
