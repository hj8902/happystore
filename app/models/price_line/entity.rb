module PriceLine
    class Entity < ApplicationRecord

        self.table_name = :price_lines

        scope :line, -> (price) { where('min_price <= ?', price).order(min_price: :desc).first }

        has_many :units, class_name: 'PriceLine::Unit', foreign_key: :price_line_id
        has_many :products, through: :units

        validates :min_price, presence: { message: error(:required, :min_price) }
        validates :max_price, presence: { message: error(:required, :max_price) }

        def name
            "#{self.min_price} ~ #{self.max_price}"
        end
        
    end
end
