class ProductsController < ApplicationController

    DEFAULT_PAGE = 1
    DEFAULT_PER = 30

    api :GET, '/products', 'List of product'
    param :page, [Integer, String], required: false, desc: 'current page'
    param :per, [Integer, String], required: false, desc: 'product count per page'
    param :category_id, [Integer, String], required: false, desc: 'ID of category what you want to see'
    param :price_line_id, [Integer, String], required: false, desc: 'ID of price line what you want to see'
    param :sale, [TrueClass, String], required: false, desc: 'if you want to see products for sale'
    formats ['json']
    def index
        # search params
        if category_id = parameters[:category_id]
            category = Category::Entity.find_by(id: category_id) 
        end

        if price_line_id = parameters[:price_line_id]
            price_line = PriceLine::Entity.find_by(id: price_line_id) 
        end

        # search
        searcher = Product::Searcher.new(parameters[:page], parameters[:per])

        json_response({ 
            products: products_json(searcher.search(category, price_line, parameters[:sale] == 'true')),
            pagination: searcher.pagination
        })
    end

    api :GET, '/products/:id', 'Show product'
    param :id, [Integer, String], required: true, desc: 'ID of product'
    formats ['json']
    def show
        json_response({ product: product_json(Product::Entity.find(params[:id])) })
    end

    private

    def products_json(products)
        products.map { |product| product_json(product) }
    end

    def product_json(product)
        view = product.as_json(only: [:id, :name, :price, :quantity, :created_at, :updated_at])
        view = view.merge({ under_sale: product.under_sale?, sold_out: product.sold_out? })
        if (product.under_sale?)
            view = view.merge({ sale: sale_json(product.sale) })
        end

        view
    end

    def sale_json(sale)
        sale.as_json(only: [:description, :percentage, :price])
    end

    def parameters
        params.permit(params.keys).to_h.symbolize_keys
    end

end
