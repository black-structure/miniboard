require 'test_helper'

class Admin::BoardsControllerTest < ActionController::TestCase
  setup do
    @admin_board = admin_boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_board" do
    assert_difference('Admin::Board.count') do
      post :create, admin_board: {  }
    end

    assert_redirected_to admin_board_path(assigns(:admin_board))
  end

  test "should show admin_board" do
    get :show, id: @admin_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_board
    assert_response :success
  end

  test "should update admin_board" do
    put :update, id: @admin_board, admin_board: {  }
    assert_redirected_to admin_board_path(assigns(:admin_board))
  end

  test "should destroy admin_board" do
    assert_difference('Admin::Board.count', -1) do
      delete :destroy, id: @admin_board
    end

    assert_redirected_to admin_boards_path
  end
end
