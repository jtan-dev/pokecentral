class CategoriesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(15)
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
end
