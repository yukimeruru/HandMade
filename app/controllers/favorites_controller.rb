class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    item = Item.find(params[:item_id])
    favorite = current_user.favorite.new(item_id: item.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    item = Item.find(params[:item_id])
    favorite = current_user.favorite.find_by(item_id: item.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end
