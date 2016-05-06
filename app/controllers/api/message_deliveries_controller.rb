class Api::MessageDeliveriesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    children = Child.completed_profile.actived_profile.not_recipient.select { |child| child.valid_age_in_weeks? }
    managerMessage = MessageDeliveries::ManagerMessageDeliveries.create(messages_created_start: Time.now, sum_messages_created: children.size)

    children.each do |child|
      MessageSenderWorker.perform_async(Date.today, child.id)
    end
    head :ok
  end

  def check_numbers
    number = params[:number].sub /(\d{4})(\d{4})/, '\1-\2'
    user = User.where("search_column like ?", "%#{number}%").first
    if user.present?
      donor = Profile.find(params[:donorId])
      SmsResponse.create(donor: donor.user, recipient: user, text: params[:text])
    end
    head :ok
  end

end
