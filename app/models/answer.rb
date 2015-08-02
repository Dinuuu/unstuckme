class Answer < ActiveRecord::Base
  EXPERIENCE_PER_ANSWER = 5
  belongs_to :question
  belongs_to :option
  validates :question, :option, :voter, presence: true
end
