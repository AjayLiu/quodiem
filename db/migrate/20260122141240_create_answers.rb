class CreateAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :answers do |t|
      t.string :content

      t.timestamps
    end
  end
end
