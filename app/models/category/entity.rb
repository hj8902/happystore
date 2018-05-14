module Category
    class Entity < ApplicationRecord
    
        self.table_name = :categories

        scope :root, -> { where.not(id: Hierarchy.all.map(&:category_id).uniq) }

        has_one :hierarchy, class_name: 'Category::Hierarchy', foreign_key: :category_id

        has_many :children_hierarchies, class_name: 'Category::Hierarchy', foreign_key: :parent_category_id
        has_many :children, class_name: 'Category::Entity', through: :children_hierarchies, source: :category

        has_many :units, class_name: 'Category::Unit', foreign_key: :category_id
        has_many :products, through: :units

        validates :name, presence: { message: error(:required, :name) }

        def root?
            !self.hierarchy
        end

        def parent
            return if root?
            self.hierarchy.parent_category
        end

        def ancestor(result = [])
            return result if self.root?
            return result unless parent = self.parent

            result << parent
            parent.ancestor(result)
        end

        def descendant(result = [])
            children = self.children
            return result if children.empty?
            
            result << children
            children.each { |child| child.descendant(result) }
            result.flatten
        end

        def belong_to(parent = nil)
            return unless parent
            hierarchy = Hierarchy.new(category_id: self.id, parent_category_id: parent.id)
            hierarchy.save!
        end

    end
end
