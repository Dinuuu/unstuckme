class AddLimitToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :limit, :integer
  end
end
