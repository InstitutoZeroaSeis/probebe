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
          self.send_message_to_donated child
        end
      end

      def self.remove_children_for_donation(profile, children_qtd)
        limit = children_qtd.abs
        children = profile.donations_children.limit(limit)
        children.update_all(donor_id: nil, was_recipient_until: DateTime.now)
      end

      def self.recipient_children(limit)
        was_recipient_children = Child.recipients(profiles_with_priority)
                                      .was_recipient(limit)
                                      .to_a

        limit = limit - was_recipient_children.size

        children = Child.recipients(profiles_with_priority)
                        .was_not_recipient(limit)
                        .to_a

        was_recipient_children.concat children
      end

      def self.send_message_to_donated(child)
        if child.was_recipient_until.present?
          MessageDeliveries::ZenviaSmsSender.send(
                                   child.profile.cell_phone_numbers,
                                   Engine.first.warning_message_donated )
        end
        unless child.was_recipient_until.present?
          MessageDeliveries::ZenviaSmsSender.send(
                         child.profile.cell_phone_numbers,
                         Engine.first.welcame_message )
        end
      end

      def self.profiles_with_priority
        priority_profiles = User.unauthorized_receive_sms.pluck('profiles.id')
        if priority_profiles.empty?
          priority_profiles = User.authorized_receive_sms.pluck('profiles.id')
        end
        priority_profiles
      end

    end
  end
end
