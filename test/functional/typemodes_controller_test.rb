require 'test_helper'

class TypemodesControllerTest < ActionController::TestCase
  setup do
    @typemode = typemodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:typemodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create typemode" do
    assert_difference('Typemode.count') do
      post :create, typemode: { title: @typemode.title }
    end

    assert_redirected_to typemode_path(assigns(:typemode))
  end

  test "should show typemode" do
    get :show, id: @typemode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @typemode
    assert_response :success
  end

  test "should update typemode" do
    put :update, id: @typemode, typemode: { title: @typemode.title }
    assert_redirected_to typemode_path(assigns(:typemode))
  end

  test "should destroy typemode" do
    assert_difference('Typemode.count', -1) do
      delete :destroy, id: @typemode
    end

    assert_redirected_to typemodes_path
  end
end
