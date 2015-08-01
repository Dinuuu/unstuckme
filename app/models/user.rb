class User < ActiveRecord::Base
	validates :device_token, presence: true, uniqueness: true
  validates :answered_questions, :questions_asked,
            :my_questions_answers, presence: true,
            numericality: { integer_only: true, greater_than_or_equal_to: 0 }
  after_initialize :initialize_fields

  private

  def initialize_fields
    self.answered_questions ||= 0
    self.questions_asked ||= 0
    self.my_questions_answers ||= 0
  end
end
