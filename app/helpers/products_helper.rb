# frozen_string_literal: true

module ProductsHelper
  def current_product
    @current_product = Product.find($id_current_product)
  end

  def status
    if (current_product.size_s.to_i + current_product.size_m.to_i + current_product.size_l.to_i + current_product.size_xl.to_i).positive?
      return 1
    end

    0
  end

  def max_quantity(id, size)
    @product = Product.find_by(id:)
    case size
    when 'S' then @product.size_s
    when 'M' then @product.size_m
    when 'L' then @product.size_l
    else
      @product.size_xl
    end
  end
end
