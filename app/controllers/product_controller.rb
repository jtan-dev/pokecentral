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

        if params[:category] != ""
            @products = Product.where("(name LIKE ? OR description LIKE ?) AND category_id = ?", wildcard_search, wildcard_search, params[:category]).page(params[:page]).per(15)
        else
            @products = Product.where("(name LIKE ? OR description LIKE ?)", wildcard_search, wildcard_search).page(params[:page]).per(15)
        end
    end
end
