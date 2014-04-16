class HomesController < ApplicationController
  def index
    unless current_user.present?
      redirect_to new_user_session_path
    else
      redirect_to products_path
    end
  end
end
