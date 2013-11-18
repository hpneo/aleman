class HomeController < ApplicationController
  def index
    if user_signed_in?
      render 'index'
    else
      redirect_to sign_in_path
    end
  end
end
