class Category::UnitTest < ApplicationTest
  
  def setup
    @root = category_entities(:root)
    @second = category_entities(:second)
    @leaf = category_entities(:leaf)

    @new_product = Product::Entity.new(name: 'new_product', price: 40000, quantity: 2)
    @new_product.save

    @unit = Category::Unit.new(category: @root, product: @new_product)
  end

  test "have to throw exception if category_unit does not have category" do
    do_not_have_attribute @unit, :required, :category, :category_id
  end

  test "have to throw exception if category_unit does not have product" do
    do_not_have_attribute @unit, :required, :product, :product_id
  end

  test "category unit must be created after calling categorize" do
    increased_count = @leaf.ancestor.length + 1
    assert_difference 'Category::Unit.count', increased_count do
      Category::Unit.categorize(@leaf, @new_product)
      assert Category::Unit.find_by(category: @leaf, product: @new_product).present?
      @leaf.ancestor.each do |category|
        assert Category::Unit.find_by(category: category, product: @new_product).present?
      end
    end
  end
  
end
