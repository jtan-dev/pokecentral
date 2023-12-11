class ProductController < ApplicationController
    before_action :initialize_session
    before_action :load_cart
    def index
        @products = Product.page(params[:page]).per(15)
    end

    def show
        @product = Product.find(params[:id])
    end

    def initialize_session
        session[:cart] ||= []
    end

    def add_to_cart
        id = params[:id].to_i
        session[:cart] << id unless session[:cart].include?(id)
        redirect_to root_path
    end

    def remove_from_cart
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to root_path
    end
    
    def load_cart
        @cart = Product.find(session[:cart])
    end

    def search
        wildcard_search = "%#{params[:q]}%"

        three_days_ago = Date.current - 3.days



        if params[:category] && params[:category] != ""
            @category = Category.find(params[:category])
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
