class Option < ActiveRecord::Base
	validates :option, presence: true
  validates :votes, numericality: { integer_only: true, greater_than_or_equal_to: 0 }
  after_initialize :initialize_fields

  belongs_to :question, inverse_of: :options

  private

  def initialize_fields
    self.votes ||= 0
  end
end
