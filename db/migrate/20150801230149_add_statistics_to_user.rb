class AddStatisticsToUser < ActiveRecord::Migration
  def change
    add_column :users, :answered_questions, :integer
    add_column :users, :questions_asked, :integer
    add_column :users, :my_questions_answers, :integer
  end
end
