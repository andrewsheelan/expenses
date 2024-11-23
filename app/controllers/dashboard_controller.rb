class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = current_user.expenses.includes(:category)
    @categories = current_user.categories

    # Monthly spending data
    @monthly_spending = @expenses
      .group_by { |e| e.date.beginning_of_month }
      .transform_values { |expenses| expenses.sum(&:amount) }
      .sort.to_h

    # Category spending
    @category_spending = @expenses
      .group_by { |e| e.category.name }
      .transform_values { |expenses| expenses.sum(&:amount) }

    # Prediction data
    @prediction_data = calculate_predictions
  end

  private

  def calculate_predictions # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    return {} if @monthly_spending.empty?

    # Calculate the trend using linear regression
    # Generate x and y values
    x_values = @monthly_spending.keys.map.with_index { |date, i| i }
    y_values = @monthly_spending.values

    n = x_values.length
    return {} if n < 2

    # Calculate slope and intercept
    sum_x = x_values.sum
    sum_y = y_values.sum
    sum_xy = x_values.zip(y_values).sum { |x, y| x * y }
    sum_xx = x_values.sum { |x| x * x }

    slope = (n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x)
    intercept = (sum_y - slope * sum_x) / n

    # Generate predictions for next 3 months
    last_month = @monthly_spending.keys.last
    predictions = {}

    3.times do |i|
      next_month = last_month + (i + 1).month
      predicted_value = [ intercept + slope * (n + i), 0 ].max
      predictions[next_month] = predicted_value.round(2)
    end

    predictions
  end
end
