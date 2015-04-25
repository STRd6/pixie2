require 'test_helper'

class SpritesControllerTest < ActionController::TestCase
  setup do
    @sprite = sprites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sprites)
  end

  test "should create sprite" do
    assert_difference('Sprite.count') do
      post :create, sprite: { description: @sprite.description, height: @sprite.height, image_url: @sprite.image_url, owner_id: @sprite.owner_id, parent_id: @sprite.parent_id, title: @sprite.title, width: @sprite.width }
    end

    assert_response 201
  end

  test "should show sprite" do
    get :show, id: @sprite
    assert_response :success
  end

  test "should update sprite" do
    put :update, id: @sprite, sprite: { description: @sprite.description, height: @sprite.height, image_url: @sprite.image_url, owner_id: @sprite.owner_id, parent_id: @sprite.parent_id, title: @sprite.title, width: @sprite.width }
    assert_response 204
  end

  test "should destroy sprite" do
    assert_difference('Sprite.count', -1) do
      delete :destroy, id: @sprite
    end

    assert_response 204
  end
end
