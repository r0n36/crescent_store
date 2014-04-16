require 'test_helper'

class DailyExpensesControllerTest < ActionController::TestCase
  setup do
    @daily_expense = daily_expenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_expenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_expense" do
    assert_difference('DailyExpense.count') do
      post :create, daily_expense: {  }
    end

    assert_redirected_to daily_expense_path(assigns(:daily_expense))
  end

  test "should show daily_expense" do
    get :show, id: @daily_expense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_expense
    assert_response :success
  end

  test "should update daily_expense" do
    patch :update, id: @daily_expense, daily_expense: {  }
    assert_redirected_to daily_expense_path(assigns(:daily_expense))
  end

  test "should destroy daily_expense" do
    assert_difference('DailyExpense.count', -1) do
      delete :destroy, id: @daily_expense
    end

    assert_redirected_to daily_expenses_path
  end
end
