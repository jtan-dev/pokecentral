class ContactAboutPagesController < ApplicationController
  def show
    @contact_about_page = ContactAboutPage.find_by(title: params[:title])
  end
end
