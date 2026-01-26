class AddScheduledForToQuestions < ActiveRecord::Migration[8.1]
  def change
    add_column :questions, :scheduled_for, :date
    add_index :questions, :scheduled_for
  end
end
