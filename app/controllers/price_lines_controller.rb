class PriceLinesController < ApplicationController

    def index
        json_response({ price_lines: price_lines_json(PriceLine::Entity.all) })
    end

    private

    def price_lines_json(price_lines)
        price_lines.map { |price_line| price_line_json(price_line) }
    end

    def price_line_json(price_line)
        price_line.as_json(only: [:id, :min_price, :max_price]).merge({ name: price_line.name })
    end

end
