module Category
    class Unit < ApplicationRecord

        self.table_name = :categories_products

        belongs_to :category, class_name: 'Category::Entity', foreign_key: :category_id
        belongs_to :product, class_name: 'Product::Entity', foreign_key: :product_id

        class << self
            
            def categorize(target, product)
                categories = target.ancestor
                categories << target
                
                product.transaction do
                    categories.each do |category|
                        options = { category_id: category.id, product_id: product.id }
                        unless self.find_by(options)
                            unit = self.new(options)
                            unit.save!
                        end
                    end
                end
            end

        end
        
    end
end
