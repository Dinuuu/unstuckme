class CreateUnlockedQuestions < ActiveRecord::Migration
  def change
    create_table :unlocked_questions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
