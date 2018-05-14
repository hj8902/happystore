class Category::HierarchyTest < ApplicationTest
  
  def setup
    @second_root = category_hierarchies(:second_root)
  end

  # test "have to throw exception if category hierarchy does not have category" do
  #   do_not_have_attribute @second_root, :required, :category, :category_id
  # end

  # test "have to throw exception if category hierarchy does not have parent_category_id" do
  #   do_not_have_attribute @second_root, :required, :parent_category, :parent_category_id
  # end  
end
