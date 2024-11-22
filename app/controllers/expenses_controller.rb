class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [ :show, :edit, :update, :destroy ]

  # GET /expenses or /expenses.json
  def index
    @expenses = current_user.expenses.includes(:category).order(date: :desc)
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = current_user.expenses.build
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to expenses_path, notice: "Expense was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: "Expense was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = current_user.expenses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:title, :amount, :date, :description, :category_id)
    end
end
