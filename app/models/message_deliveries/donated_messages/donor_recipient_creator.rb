module MessageDeliveries
  module DonatedMessages
    class DonorRecipientCreator
      def self.create(profile)
        children_qtd = profile.max_recipient_children - profile.donations_children.size
        children = Child.joins(:profile).where(donor: nil).where(profiles: { profile_type: Profile.profile_types[:recipient] }).limit(children_qtd)

        children.update_all(donor_id: profile.id)
      end
    end
  end
end
