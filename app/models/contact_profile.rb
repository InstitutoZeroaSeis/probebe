class ContactProfile < ActiveRecord::Base

  belongs_to :profile
  has_many :phones

  accepts_nested_attributes_for :phones, allow_destroy: true
  
  validate :has_dumpphone_or_smartphone


  private

  def has_dumpphone_or_smartphone
    unless phones.any? {|p| ["dumpphone", "smartphone"].include? p.phone_type }
      errors.add(:base, I18n.t('activerecord.errors.models.phone.base.needs_some_mobile_phone'))
    end
  end

end
