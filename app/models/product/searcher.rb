module Product
    class Searcher

        DEFAULT_PAGE = 1
        DEFAULT_PER = 30

        def initialize(page = nil, per = nil)
            @page = page || DEFAULT_PAGE
            @per = per || DEFAULT_PER
            @offset = (@page.to_i - 1) * @per.to_i
            @total_page = 0
            @total_count = 0
        end

        def search(category = nil, price_line = nil, sale = false)
            if !category && !price_line && !sale
                return search_result(Product::Entity.all.includes(:sale))
            end

            ids = sale ? ids(Sale.all, :product_id) : []
            
            if price_line
                ids = ids.empty? ?
                    union(ids, ids_belong_to_price_line(price_line)) :
                    intersection(ids, ids_belong_to_price_line(price_line))
            end

            if category
                category_ids = category.descendant.map(&:id)
                category_ids << category.id
                ids = ids.empty? ?
                    union(ids, ids_belong_to_category(category_ids)) :
                    intersection(ids, ids_belong_to_category(category_ids))
            end

            search_result(Product::Entity.where(id: ids).includes(:sale))
        end

        def pagination
            { page: @page, per: @per, total_page: @total_page, total_count: @total_count }
        end

        private
        def search_result(query)
            count(query)
            query.limit(@per).offset(@offset)
        end

        def count(query)
            @total_count = query.count
            @total_page = (@total_count / @per.to_i) + 1
        end

        def ids_belong_to_price_line(price_line)
            ids(PriceLine::Unit.joins(:price_line).where(price_line: price_line), :product_id)
        end

        def ids_belong_to_category(category_ids)
            ids(Category::Unit.joins(:category).where(category_id: category_ids), :product_id)
        end

        def ids(array, key = :id)
            array.map(&key)
        end

        def union(a, b)
            (a + b).uniq
        end

        def intersection(a, b)
            a & b
        end

    end
end