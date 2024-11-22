class AddUserToCategories < ActiveRecord::Migration[8.0]
  def change
    add_reference :categories, :user, null: false, foreign_key: true
  end
end
