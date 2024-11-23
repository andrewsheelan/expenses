class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /categories
  def index
    @categories = current_user.categories.search(params[:query]).order(created_at: :desc)
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = current_user.categories.build
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to @category, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    if @category.expenses.any?
      redirect_to categories_url, alert: "Cannot delete category with existing expenses."
    else
      @category.destroy
      redirect_to categories_url, notice: "Category was successfully destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
end
