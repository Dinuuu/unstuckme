class User < ActiveRecord::Base
  INITIAL_CREDITS = 20
	validates :device_token, presence: true, uniqueness: true
  validates :answered_questions, :questions_asked,
            :my_questions_answers, :credits, :experience, presence: true,
            numericality: { integer_only: true, greater_than_or_equal_to: 0 }
  after_initialize :initialize_fields

  def level
    if experience < 20
      1
    else
      (Math.log2(experience / 5.0)).floor
    end
  end

  private

  def initialize_fields
    self.answered_questions ||= 0
    self.questions_asked ||= 0
    self.my_questions_answers ||= 0
    self.experience ||= 0
    self.credits ||= 20
  end
end
