module ProductHelper

  def product_brand_name(product)
    if product.brand.nil?
      content_tag :td, " "
    else
      content_tag :td, product.brand.name
    end
  end

  def like?(id)
    user_signed_in? && current_user.like_user?(id)
  end

  def get_label(like_decision)
    if like_decision
      "like"
    else
      "dis-like"
    end
  end
end
