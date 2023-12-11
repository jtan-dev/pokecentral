class ProductController < ApplicationController
    def index
        @products = Product.page(params[:page]).per(15)
    end

    def show
        @product = Product.find(params[:id])
    end

    def search
        wildcard_search = "%#{params[:q]}%"

        three_days_ago = Date.current - 3.days

        if params[:category] != ""
            @products = Product.where("(name LIKE ? OR description LIKE ?) AND category_id = ?", wildcard_search, wildcard_search, params[:category]).page(params[:page]).per(15)
        elsif params[:category] == ""
            @products = Product.where("(name LIKE ? OR description LIKE ?)", wildcard_search, wildcard_search).page(params[:page]).per(15)
        end

        if params[:filter] == "new"
            @products = Product.where("created_at >= ?", three_days_ago.beginning_of_day).page(params[:page]).per(15)
        elsif params[:filter] == "updated"
            @products = Product.where("created_at < ? AND updated_at >= ?", three_days_ago.beginning_of_day, three_days_ago.beginning_of_day).page(params[:page]).per(15)
        end
    end
end
