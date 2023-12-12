class ApplicationController < ActionController::Base
  before_action :load_categories, :load_pages
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def load_categories
    @categories = Category.all
  end

  def load_pages
    @pages = ContactAboutPage.all
  end

  def configure_permitted_parameters
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:street_address, :city, :postal_code, :province_id])
    end
  end
end
