class RecipientDonorWorker
  include Sidekiq::Worker

  def perform
    Profile.donor.each do |profile|
      next if profile.donations_children.size >= profile.max_recipient_children
      MessageDeliveries::DonatedMessages::
        DonorRecipientCreator.create(profile)
    end
  end

end
