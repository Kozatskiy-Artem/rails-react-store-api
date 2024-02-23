class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[ create ]
  before_action :set_current_user, only: %i[ create ]

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order, include: { orders_descriptions: { include: :item } }
  end

  # POST /orders
  def create
    @order = @current_user.orders.build(amount: order_params[:amount])
    order_params[:items].each do |item|
      @order.orders_descriptions.build(item_id: item[:item_id], quantity: item[:quantity])
    end

    if @order.save
      render json: @order, include: { orders_descriptions: { include: :item } }, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.permit(:amount, items: [:item_id, :quantity])
    end

    def set_current_user
      @current_user = current_devise_api_token.resource_owner
    end
end
