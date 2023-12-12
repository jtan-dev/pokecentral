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
    cart_items = {"id" => id, "qty" => 1}

    if session[:cart].any?{ |i| i["id"] == id}
        session[:cart][session[:cart].index {|i| i["id"] == id}]["qty"] += 1
    else
        session[:cart] << cart_items
    end
    redirect_to root_path
end

def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete_at(session[:cart].index {|i| i["id"] == id})
    redirect_to root_path
end

def add_remove_quantity
    id = params[:product_id].to_i
    new_quantity = params[:quantity].to_i
    session[:cart][session[:cart].index {|i| i["id"] == id}]["qty"] = new_quantity
    redirect_to root_path
end

def load_cart
    @cart = []
    session[:cart].each do |item|
        product = Product.find(item["id"])
        @cart << {"product" => product, "qty" => item["qty"]}
    end
end
end
