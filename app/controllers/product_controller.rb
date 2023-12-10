class ProductController < ApplicationController
    def index
        @products = Product.page(params[:page]).per(15)
    end

    def show
        @product = Product.find(params[:id])
    end

    def search
        wildcard_search = "%#{params[:q]}%"

        if params[:category] != ""
            @products = Product.where("(name LIKE ? OR description LIKE ?) AND category_id = ?", wildcard_search, wildcard_search, params[:category]).page(params[:page]).per(15)
        else
            @products = Product.where("(name LIKE ? OR description LIKE ?)", wildcard_search, wildcard_search).page(params[:page]).per(15)
        end
    end
end
