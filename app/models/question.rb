class Question < ActiveRecord::Base
  MIN_OPTIONS = 2
  MAX_OPTIONS = 4
  has_many :options, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :options
  validates :creator, presence: true
  validates :exclusive, inclusion: { in: [true, false] }
  validates :options, length: { minimum: MIN_OPTIONS, maximum: MAX_OPTIONS }

  scope :for_user, -> (user) { where(creator: user) }
end
