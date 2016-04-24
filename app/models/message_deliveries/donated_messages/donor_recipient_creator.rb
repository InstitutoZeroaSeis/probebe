module MessageDeliveries
  module DonatedMessages
    class DonorRecipientCreator
      def self.create(profile)
        children_qtd = profile.max_recipient_children - profile.donations_children.size
        return if children_qtd == 0

        if children_qtd > 0
          self.choose_children_for_donation(profile, children_qtd)
        else
          self.remove_children_for_donation(profile, children_qtd)
        end
      end

      def self.choose_children_for_donation(profile, children_qtd)
        children = self.recipient_children(children_qtd)
        children.each do |child|
          child.update_attributes(donor_id: profile.id, was_recipient_until: nil)
        end
      end

      def self.remove_children_for_donation(profile, children_qtd)
        limit = children_qtd.abs
        children = profile.donations_children.limit(limit)
        children.update_all(donor_id: nil, was_recipient_until: DateTime.now)
        children.each { |child| child.profile.authorize_receive_sms! }
      end

      def self.recipient_children(limit)
        base_query = Child.joins(:profile).
                where(donor: nil).
                where(profiles: { profile_type: Profile.profile_types[:recipient] })

        was_recipient_children = base_query.
                where.not(was_recipient_until: nil).
                limit(limit).to_a

        limit = limit - was_recipient_children.size

        children = base_query.
                where(was_recipient_until: nil).
                limit(limit).to_a

        was_recipient_children.concat children
      end


    end
  end
end
