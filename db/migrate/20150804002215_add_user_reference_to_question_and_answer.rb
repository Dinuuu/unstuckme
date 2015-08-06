class AddUserReferenceToQuestionAndAnswer < ActiveRecord::Migration
  def change
  	add_reference :questions, :user, index: true, foreign_key: true
  	add_reference :answers, :user, index: true, foreign_key: true
  	Question.all.each do |q|
  		q.update_attributes!(user_id: User.find_by_device_token(q.creator).id)
  	end
  	Answer.all.each do |a|
  		a.update_attributes!(user_id: User.find_by_device_token(a.voter).id)
  	end

    remove_column :answers, :voter
    remove_column :questions, :creator
  end
end
