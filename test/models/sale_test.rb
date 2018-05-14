class SaleTest < ApplicationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @product = product_entities(:product_1)

    @sale = Sale.new(
      product: @product,
      description: "product 1 mega sale",
      percentage: 50
    )
  end

  test "have to throw exception if sale does not have product" do
    do_not_have_attribute @sale, :required, :product, :product_id
  end

  test "have to throw exception if sale does not have description" do
    do_not_have_attribute @sale, :required, :description
  end

  test "have to throw exception if sale does not have percentage" do
    do_not_have_attribute @sale, :required, :percentage
  end

  test "have to be price if sale is saved" do
    assert_nil @sale.price
    @sale.save

    expected_price_for_sale = @product.price - (@product.price * ( @sale.percentage.to_f / 100 )).to_i
    assert_equal @sale.price, expected_price_for_sale
  end

  test "sale cannot be duplicated" do
    @sale.save
    
    attribute_name = message_for_attrubute(@sale, :product_id)
    expected_message = message_for_type(:duplicated, { attribute: attribute_name })

    second = Sale.new(
      product: @product,
      description: "product 1 mega sale",
      percentage: 30
    )

    exception = assert_raise Exception do
      second.save!
    end

    assert_equal exception.message, expected_message
  end
end
