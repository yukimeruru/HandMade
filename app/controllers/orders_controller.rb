class OrdersController < ApplicationController
  before_action :autheniticate_user!

  def new
    @order = Order.new
    @item = Item.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    @order = current_user.orders.new(order_params)
    @order.user_id = user.id
    if @order.save
      redirect_to items_path
    else
      render :new
    end
  end

  def reply
    @order = Order.new
    @order_date = Order.find(params[:id])
  end

  def index
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    Order.find_by(params[:id]).destroy
    redirect_to orders_path(current_user)
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :item_id, :order_comment, :comment_status)
  end

end
