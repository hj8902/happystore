module Product
    class Entity < ApplicationRecord
    
        self.table_name = :products

        has_one :sale, class_name: 'Sale', foreign_key: :product_id

        validates :name, presence: { message: error(:required, :name) }
        validates :price, presence: { message: error(:required, :price) }
        validates :quantity, presence: { message: error(:required, :quantity) }

        def under_sale?
            sale.present?
        end

        def sold_out?
            quantity == 0
        end
    end
end