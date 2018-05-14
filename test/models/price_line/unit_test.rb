class PriceLine::UnitTest < ApplicationTest
  
  def setup
    min_price = PriceLine::Entity.last.max_price + 1
    max_price = min_price + 50000 - 1

    @next_price_line = PriceLine::Entity.new(min_price: min_price, max_price: max_price)
    @next_price_line.save

    @new_product = Product::Entity.new(name: 'new_product', price: (max_price + min_price) / 2, quantity: 2)
    @new_product.save

    @unit = PriceLine::Unit.new(price_line: @next_price_line, product: @new_product)
  end

  test "have to throw exception if price_line_unit does not have price_line" do
    do_not_have_attribute @unit, :required, :price_line, :price_line_id
  end

  test "have to throw exception if price_line_unit does not have product" do
    do_not_have_attribute @unit, :required, :product, :product_id
  end

  test "price unit must be created after calling categorize_by_price" do
    assert_difference 'PriceLine::Unit.count', 1 do
      PriceLine::Unit.categorize_by_price(@new_product)
      unit = PriceLine::Unit.find_by(product: @new_product)
      assert_equal unit.price_line, @next_price_line
    end
  end

end
