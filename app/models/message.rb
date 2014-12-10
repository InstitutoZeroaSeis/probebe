class Message < ActiveRecord::Base
  include Carnival::ModelHelper
  MAXIMUM_POSSIBLE_WEEK = 5200

  belongs_to :category
  belongs_to :messageable, polymorphic: true
  has_many :message_deliveries

  enum gender: [:male, :female, :both]
  enum baby_target_type: [:pregnancy, :born]

  validates_presence_of :text

  scope :male_and_both, -> { where(gender:[0,2]) }
  scope :female_and_both, -> { where(gender:[1,2]) }
  scope :journalistic, -> { where(messageable_type: 'Articles::JournalisticArticle') }

  before_save :set_messageable_type

  def set_messageable_type
    if messageable_type
      self.messageable_type = messageable.class.to_s
    end
  end

  def message_already_sent_for_profile(profile)
    profile.message_deliveries.none? do |delivery|
      self == delivery.message
    end
  end

  def age_valid_for_message?(age_in_weeks)
    min_week = minimum_valid_week || 0
    max_week = maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
    (min_week..max_week).include? age_in_weeks
  end


  def distance_for_maximum_valid_week(age_in_weeks)
    max_week = maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
    max_week - age_in_weeks
  end

end
