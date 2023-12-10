class ProductController < ApplicationController
    def index
        @products = Product.page(params[:page]).per(15)
    end

    def show
        @product = Product.find(params[:id])
    end

    def search
        wildcard_search = "%#{params[:keywords]}%"
        @products = Product.where("name LIKE ?", wildcard_search).page(params[:page]).per(15)
    end
end
