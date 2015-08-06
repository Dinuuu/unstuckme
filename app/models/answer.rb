class Answer < ActiveRecord::Base
  EXPERIENCE_PER_ANSWER = 5
  belongs_to :question
  belongs_to :option
  belongs_to :user
  validates :question, :option, :user, presence: true

  scope :for_user, -> (user) { where(user: user) }
end
