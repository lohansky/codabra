require 'test_helper'

class CodabrasControllerTest < ActionController::TestCase
  setup do
    @codabra = codabra(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:codabras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create codabra" do
    assert_difference('Codabra.count') do
      post :create, codabra: @codabra.attributes
    end

    assert_redirected_to codabra_path(assigns(:codabra))
  end

  test "should show codabra" do
    get :show, id: @codabra.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @codabra.to_param
    assert_response :success
  end

  test "should update codabra" do
    put :update, id: @codabra.to_param, codabra: @codabra.attributes
    assert_redirected_to codabra_path(assigns(:codabra))
  end

  test "should destroy codabra" do
    assert_difference('Codabra.count', -1) do
      delete :destroy, id: @codabra.to_param
    end

    assert_redirected_to codabras_path
  end
end
