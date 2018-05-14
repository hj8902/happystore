class Sale < ApplicationRecord

    self.table_name = :sales

    belongs_to :product, class_name: 'Product::Entity', foreign_key: :product_id

    validates :percentage, presence: { message: error(:required, :percentage) }
    validates :description, presence: { message: error(:required, :description) }

    before_save :validate_duplication, :calculate_price_for_sale

    private 

    def validate_duplication
        raise Exception.new(self.class.error(:duplicated, :product_id)) unless Sale.where(product_id: self.product_id).empty?
    end
    
    def calculate_price_for_sale
        discount = (self.product.price * (self.percentage.to_f / 100)).to_i
        self.price = self.product.price - discount
    end
    
end
