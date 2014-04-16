class DailyExpensesController < ApplicationController
  before_action :set_daily_expense, only: [:show, :edit, :update, :destroy]

  # GET /daily_expenses
  # GET /daily_expenses.json
  def index
    @daily_expense_tab = 'active'
    @daily_expenses = DailyExpense.all
  end

  # GET /daily_expenses/1
  # GET /daily_expenses/1.json
  def show
    @daily_expense_tab = 'active'
  end

  # GET /daily_expenses/new
  def new
    @daily_expense_tab = 'active'
    @daily_expense = DailyExpense.new
  end

  # GET /daily_expenses/1/edit
  def edit
    @daily_expense_tab = 'active'
  end

  # POST /daily_expenses
  # POST /daily_expenses.json
  def create
    @daily_expense = DailyExpense.new(daily_expense_params)

    respond_to do |format|
      if @daily_expense.save
        format.html { redirect_to @daily_expense, notice: 'Daily expense was successfully created.' }
        format.json { render action: 'show', status: :created, location: @daily_expense }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_expenses/1
  # PATCH/PUT /daily_expenses/1.json
  def update
    respond_to do |format|
      if @daily_expense.update(daily_expense_params)
        format.html { redirect_to @daily_expense, notice: 'Daily expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @daily_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_expenses/1
  # DELETE /daily_expenses/1.json
  def destroy
    @daily_expense.destroy
    respond_to do |format|
      format.html { redirect_to daily_expenses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_expense
      @daily_expense = DailyExpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_expense_params
      params[:daily_expense]
    end
end
