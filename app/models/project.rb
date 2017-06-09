class Project < ApplicationRecord
  validates :brief, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :funding_duration, presence: true, allow_blank: false
  validates :funding_goal, presence: true, allow_blank: false
  belongs_to :user
  has_many :comments
  has_many :donations
  has_many :pictures, dependent: :destroy
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :passive_project_relationships, class_name:  'ProjectRelationship',
                                           foreign_key: 'saved_id',
                                           dependent:   :destroy
  has_many :savers, through: :passive_project_relationships, source: :saver
  validates_associated :comments
  validates_associated :donations
  has_attached_file :picture


  searchkick

  def saver?(user)
    savers.include?(user)
  end

  def add_category(category)
    categories << category unless categories.include? category
  end

  def remove_category(category)
    categories.delete(category)
  end

  def donated
    donations.map(&:amount).inject(0) { |sum, x| sum + x }
  end

  def percentage
    (donated.to_f * 100 / funding_goal.to_f).round
  end

  def remaining
    funding_goal - donated
  end
end
