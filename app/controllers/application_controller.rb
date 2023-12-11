class ApplicationController < ActionController::Base
  before_action :load_categories, :load_pages

  private

  def load_categories
    @categories = Category.all
  end

  def load_pages
    @pages = ContactAboutPage.all
  end
end
