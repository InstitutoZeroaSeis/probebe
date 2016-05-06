class SmsResponse < ActiveRecord::Base
  belongs_to :donor, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
