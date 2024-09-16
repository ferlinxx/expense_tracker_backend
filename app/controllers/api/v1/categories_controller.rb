class Api::V1::CategoriesController < ApplicationController
    def index
        @categories = Category.limit(6)
        render json: {categories: @categories}
    end
end
