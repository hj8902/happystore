class Product::EntityTest < ApplicationTest
  
  def setup
    @product = product_entities(:product_1)
  end

  test "have to throw exception if product does not have name" do
    do_not_have_attribute @product, :required, :name
  end

  test "have to throw exception if product does not have price" do
    do_not_have_attribute @product, :required, :price
  end

  test "have to throw exception if product does not have quantity" do
    do_not_have_attribute @product, :required, :quantity
  end

  test "product is sold out if product quantity is 0" do
    assert @product.quantity != 0
    assert_not @product.sold_out?
    
    @product.quantity = 0
    assert @product.sold_out?
  end
end
