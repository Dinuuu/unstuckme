class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :creator
      t.boolean :exclusive

      t.timestamps null: false
    end
  end
end
