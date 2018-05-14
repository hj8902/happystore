module Category
    class Hierarchy < ApplicationRecord

        self.table_name = :category_hierarchies

        scope :children_of, -> (category) { joins(:category).where(parent_category_id: category.id) }

        belongs_to :category, class_name: 'Category::Entity', foreign_key: 'category_id'
        belongs_to :parent_category, class_name: 'Category::Entity', foreign_key: 'parent_category_id'
        
    end
end
