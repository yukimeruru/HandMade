class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @item = Item.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @order = current_user.orders.new(order_params)
    @order.user_id = @user.id
    @order.reply_id = current_user.id
    if @order.save
      Mailer.send_when_post(@user).deliver
      redirect_to items_path
    else
      render :new
    end
  end

  def reply
    @order = Order.new
    @order_reply = Order.find(params[:id])
  end

  def index
    @user = current_user
    @orders = @user.orders.order("id DESC")
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
