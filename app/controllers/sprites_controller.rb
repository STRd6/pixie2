class SpritesController < ApplicationController
  before_action :set_sprite, only: [:show, :update, :destroy]

  # GET /sprites
  # GET /sprites.json
  def index
    @sprites = Sprite.limit(20)

    render json: @sprites
  end

  # GET /sprites/1
  # GET /sprites/1.json
  def show
    render json: @sprite
  end

  # POST /sprites
  # POST /sprites.json
  def create
    @sprite = Sprite.new(sprite_params)

    if @sprite.save
      render json: @sprite, status: :created, location: @sprite
    else
      render json: @sprite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sprites/1
  # PATCH/PUT /sprites/1.json
  def update
    @sprite = Sprite.find(params[:id])

    if @sprite.update(sprite_params)
      head :no_content
    else
      render json: @sprite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sprites/1
  # DELETE /sprites/1.json
  def destroy
    @sprite.destroy

    head :no_content
  end

  private

    def set_sprite
      @sprite = Sprite.find(params[:id])
    end

    def sprite_params
      params.require(:sprite).permit(:width, :height, :owner_id, :parent_id, :title, :description, :image_url)
    end
end
