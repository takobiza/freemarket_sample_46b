module ProductHelper

  def product_brand_name(product)
    if product.brand.nil?
      content_tag :td, " "
    else
      content_tag :td, product.brand.name
    end
  end

end
