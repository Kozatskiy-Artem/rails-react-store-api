class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[ create update destroy ]
  before_action :set_current_user, only: %i[ create update destroy ]

  # GET /items
  def index
    if params[:search].present?
      @items = Item.where("name LIKE ?", "%#{params[:search]}%")
    else
      @items = Item.all
    end

    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    if @current_user.admin?
      @item = Item.new(item_params)

      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  # PATCH/PUT /items/1
  def update
    if @current_user.admin?
      if @item.update(item_params)
        render json: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  # DELETE /items/1
  def destroy
    if @current_user.admin?
      @item.destroy
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :description, :price)
    end

    def set_current_user
      @current_user = current_devise_api_token.resource_owner
    end
end
