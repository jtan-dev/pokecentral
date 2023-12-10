class ProductController < ApplicationController
    def index
        @products = Product.page(params[:page]).per(15)
    end

    def show
        @product = Product.find(params[:id])
        @comments = @product.comments
    end

    def search
        wildcard_search = "%#{params[:q]}%"
        @products = Product.where("name LIKE ?", "%#{params[:q]}%")
    end
end
