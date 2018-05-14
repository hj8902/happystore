class Product::SearcherTest < ApplicationTest
  
  def setup
    @page = 1
    @per = 25
    @searcher = Product::Searcher.new(@page, @per)
  end

  test "search all product" do
    offset = (@page - 1) * @per
    assert_equal ids(@searcher.search()), ids(Product::Entity.all.limit(@per).offset(offset))
  end

  test "search product if sale" do
    create_sale
    assert_equal ids(@searcher.search(nil, nil, true)), ids(Sale.all, :product_id)
  end

  test "search product if category" do
    second_category = category_entities(:second)
    category_ids = ids(second_category.descendant)
    category_ids << second_category.id
    assert_equal ids(@searcher.search(second_category)), ids(Category::Unit.where(category_id: category_ids), :product_id)
  end

  test "search product if price_line" do
    price_line = price_line_entities(:price_line_2)
    assert_equal ids(@searcher.search(nil, price_line)), ids(PriceLine::Unit.where(price_line: price_line), :product_id)
  end

  test "search product if sale && category" do
    create_sale

    root_category = category_entities(:root)
    category_ids = ids(root_category.descendant)
    category_ids << root_category.id
    product_ids_belong_to_root_category = ids(Category::Unit.where(category_id: category_ids), :product_id)

    product_ids_belong_to_sale = ids(Sale.all, :product_id)

    product_ids = product_ids_belong_to_root_category & product_ids_belong_to_sale

    assert_equal ids(@searcher.search(root_category, nil, true)), product_ids
  end

  test "search product if sale && price_line" do
    create_sale

    price_line = price_line_entities(:price_line_1)
    product_ids_belong_to_price_line = ids(PriceLine::Unit.where(price_line: price_line), :product_id)

    product_ids_belong_to_sale = ids(Sale.all, :product_id)

    product_ids = product_ids_belong_to_price_line & product_ids_belong_to_sale

    assert_equal ids(@searcher.search(nil, price_line, true)), product_ids
  end

  test "search product if category && price_line" do
    root_category = category_entities(:root)
    category_ids = ids(root_category.descendant)
    category_ids << root_category.id
    product_ids_belong_to_root_category = ids(Category::Unit.where(category_id: category_ids), :product_id)

    price_line = price_line_entities(:price_line_1)
    product_ids_belong_to_price_line = ids(PriceLine::Unit.where(price_line: price_line), :product_id)

    product_ids = product_ids_belong_to_root_category & product_ids_belong_to_price_line

    assert_equal ids(@searcher.search(root_category, price_line)), product_ids.uniq.sort
  end

  private

  def ids(array, key = :id)
    array.map(&key).sort
  end

  def create_sale
    sale = Sale.new(
      product: product_entities(:product_1),
      description: "product 1 mega sale",
      percentage: 50
    )

    sale.save
  end

end
