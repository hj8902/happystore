module PriceLine
    class Unit < ApplicationRecord
    
        self.table_name = :price_lines_products

        belongs_to :price_line, class_name: 'PriceLine::Entity', foreign_key: :price_line_id
        belongs_to :product, class_name: 'Product::Entity', foreign_key: :product_id

        class << self
            
            def categorize_by_price(product)
                line = PriceLine::Entity.line(product.price)
                unless self.find_by(product: product)
                    unit = self.new(product: product, price_line: line)
                    unit.save!
                end
            end

        end

    end
end
