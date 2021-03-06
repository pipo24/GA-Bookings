class Cohort < ActiveRecord::Base
  has_many    :contracts, dependent: :destroy
  has_many    :users, through: :contracts
  belongs_to  :course_type
  has_many    :bookings

  validates :name, length: { minimum: 2 }, presence: true
  validate  :end_after_start
  validates :start_date, :end_date, :presence => true

  # used to check whether the start date is before the end date
  private
  def end_after_start
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date") 
    end 
  end
end
