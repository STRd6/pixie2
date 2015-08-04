class SpritesController < ApplicationController
  respond_to :html, :json

  before_filter :require_owner_or_admin, :only => [
    :destroy,
    :edit,
    :update
  ]
  before_filter :require_user, :only => [
    :add_tag,
    :remove_tag,
    :add_favorite,
    :remove_favorite
  ]

  def create
    @sprite = Sprite.create! sprite_params

    track_event('create_sprite')

    respond_to do |format|
      format.html do
        if sprite.user
          redirect_to sprite
        else
          session[:saved_sprites] ||= {}
          session[:saved_sprites][sprite.id] = 0

          redirect_to sign_in_path
        end
      end
      format.json do
        if sprite.user
          render :json => {
            :sprite => {
              :id => @sprite.id,
              :title => @sprite.title,
              :src => @sprite.image.url
            }
          }
        else
          session[:saved_sprites] ||= {}
          session[:saved_sprites][sprite.id] = 0

          render :json => { :redirect => sign_in_path }
        end
      end
    end
  end

  def new
    unless params[:width].to_i <= 0
      @width = [params[:width].to_i, Sprite::MAX_LENGTH].min
    end

    unless params[:height].to_i <= 0
      @height = [params[:height].to_i, Sprite::MAX_LENGTH].min
    end

    @sprite = Sprite.new

    render :action => :pixie
  end

  def index
    @sprites = collection

    respond_with(@sprites)
  end

  def show
    respond_with(sprite) do |format|
      format.json { render :json }
    end
  end

  def edit
  end

  def destroy
    @sprite = Sprite.find(params[:id])
    @sprite.destroy
    flash[:notice] = "Sprite has been deleted."
    respond_with(@sprite)
  end

  def update
    @sprite = Sprite.find(params[:id])

    @sprite.update_attributes(sprite_params)

    respond_with(@sprite) do |format|
      format.json { render :json => {
          :id => @sprite.id,
          :title => @sprite.display_name,
          :description => @sprite.description || "",
          :img => @sprite.image.url,
          :author => (@sprite.user) ? @sprite.user.display_name : "Anonymous",
          :author_id => @sprite.user_id
        }
      }
    end
  end

  def load
    @source_url = sprite.image.url
    @parent_id = sprite.id
    @parent_url = sprite.parent ? sprite.parent.image.url : nil
    @replay_url = sprite.replay.url

    @width = sprite.width
    @height = sprite.height

    render :action => :pixie
  end


  def import
    @sprite = Sprite.new

    @sprite.user = current_user
    if @sprite.update_attributes(params[:sprite])
      redirect_to @sprite
    else
      # Errors
      render :action => :upload
    end
  end

  def add_tag
    sprite.add_tag(params[:tag])

    respond_to do |format|
      format.json { render :json => {:status => "ok"} }
    end
  end

  def remove_tag
    sprite.remove_tag(params[:tag])

    respond_to do |format|
      format.json { render :json => {:status => "ok"} }
    end
  end

  def add_favorite
    current_user.add_favorite(sprite)

    respond_to do |format|
      format.json { render :json => {:status => "ok"} }
    end
  end

  def remove_favorite
    current_user.remove_favorite(sprite)

    respond_to do |format|
      format.json { render :json => {:status => "ok"} }
    end
  end

  private

  def sprite_params
    params[:sprite].permit(:description, :title, :width, :height, :parent_id, :replay_data, :file_base64_encoded).merge(:user => current_user)
  end

  def collection
    @title = "Sprites"

    @collection ||= if params[:tagged]
      @title += " " + params[:tagged]
      Sprite.tagged_with(params[:tagged]).order("id DESC").search(params[:search]).paginate(:page => params[:page], :per_page => per_page)
    else
      Sprite.order("id DESC").search(params[:search]).paginate(:page => params[:page], :per_page => per_page)
    end

    if params[:user_id].present?
      user = User.find_by_display_name!(params[:user_id])
      @collection = @collection.for_user(user)

      @title = "#{user.display_name}'s " + @title
    end

    return @collection
  end

  def per_page
    if params[:per_page].blank?
      187
    else
      params[:per_page].to_i
    end
  end

  helper_method :sprites
  def sprites
    return collection
  end

  helper_method :sprite
  def sprite
    return @sprite ||= Sprite.find(params[:id])
  end

  def object
    sprite
  end

  helper_method :installed_tools
  def installed_tools
    if current_user
      current_user.installed_plugins
    else
      []
    end
  end
end
