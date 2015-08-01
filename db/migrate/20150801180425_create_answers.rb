class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true, foreign_key: true
      t.references :option, index: true, foreign_key: true
      t.string :voter

      t.timestamps null: false
    end
  end
end
