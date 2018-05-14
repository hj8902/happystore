class CategoriesController < ApplicationController

    def index
        json_response({categories: categories_json(Category::Entity.root) })
    end

    private

    def categories_json(categories)
        categories.map { |category| category_json(category) }
    end

    def category_json(category)
        view = category.as_json(only: [:id, :name])
        view = view.merge({ children: category.children.map { |child| category_json(child) } }) unless category.children.empty?
        view
    end

end
