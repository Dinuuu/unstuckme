class Question < ActiveRecord::Base
  MIN_OPTIONS = 2
  MAX_OPTIONS = 4
  has_many :options, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :options
  validates :creator, :limit, presence: true
  validates :exclusive, inclusion: { in: [true, false] }
  validates :options, length: { minimum: MIN_OPTIONS, maximum: MAX_OPTIONS }
  validates :limit, numericality: { integer_only: true, greater_than: 0 }
  validates :total_votes, numericality: { integer_only: true, greater_than_or_equal_to: 0 }
  validates :active, inclusion: { in: [true, false] }

  scope :for_user, -> (user) { where(creator: user) }


  after_initialize :initialize_fields

  private

  def initialize_fields
  	self.total_votes ||= 0
  	self.active ||= active == nil ? true : active
  end
end
