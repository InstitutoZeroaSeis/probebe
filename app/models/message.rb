class Message < ActiveRecord::Base
  include Carnival::ModelHelper
  MAXIMUM_POSSIBLE_WEEK = 5200

  belongs_to :category
  belongs_to :messageable, polymorphic: true
  has_many :message_deliveries, class_name: 'MessageDeliveries::MessageDelivery'

  validates_presence_of :text

  scope :male_and_both, -> { where(gender: [0, 2]) }
  scope :female_and_both, -> { where(gender: [1, 2]) }
  scope :journalistic, -> { where(messageable_type: 'Articles::JournalisticArticle') }

  before_save :update_messageable_type

  delegate :parent_category, to: :category

  enum gender: [:male, :female, :both]
  enum baby_target_type: [:pregnancy, :born]

  def update_messageable_type
    return unless messageable_type
    self.messageable_type = messageable.class.to_s
  end

  def age_valid_for_message?(age_in_weeks)
    min_week = minimum_valid_week || 0
    max_week = maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
    (min_week..max_week).include? age_in_weeks
  end

  def remaining_weeks_till_due_date(age_in_weeks)
    max_week = maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
    max_week - age_in_weeks
  end

  def text_size
    (text || '').size
  end
end
