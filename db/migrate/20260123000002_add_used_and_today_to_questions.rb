class AddUsedAndTodayToQuestions < ActiveRecord::Migration[8.1]
  def change
    add_column :questions, :used, :boolean, default: false, null: false
    add_column :questions, :today, :boolean, default: false, null: false
  end
end
