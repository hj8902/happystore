class Category::EntityTest < ApplicationTest

  def setup
    @root = category_entities(:root)
    @second = category_entities(:second)
    @leaf = category_entities(:leaf)
  end

  test "have to throw exception if category does not have name" do
    do_not_have_attribute @root, :required, :name
  end

  test "the category is root if category does not have hierarchy" do
    assert_equal @root.hierarchy.nil?, @root.root?
  end

  test "if category is root, parent is nil and if not, category has a parent(parent's children includes the category)" do
    assert_nil @root.parent if @root.root?
    assert_not @second.root?
    assert_equal @second.parent, @root
    assert @root.children.include? @second
  end

  test "check ancestor" do
    expected_ancestor = [@second, @root].sort
    assert_equal @leaf.ancestor.sort, expected_ancestor

    expected_ancestor = [@root]
    assert_equal @second.ancestor, expected_ancestor
  end
end
