class PriceLine::EntityTest < ApplicationTest
  
  def setup
    @line = price_line_entities(:price_line_1)
  end

  test "have to throw exception if price_line does not have min_price" do
    do_not_have_attribute @line, :required, :min_price
  end

  test "have to throw exception if price_line does not have max_price" do
    do_not_have_attribute @line, :required, :max_price
  end

  test "check prive line name" do
    assert_equal @line.name, "#{@line.min_price} ~ #{@line.max_price}"
  end
end
