module ApplicationHelper
  def product_for_routing(product)
    product.becomes(Product)
  end
end
