class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :option
  validates :question, :option, :voter, presence: true
end
