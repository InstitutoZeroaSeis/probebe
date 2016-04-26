module MessageDeliveries
  module DonatedMessages
    class DonorRecipientCreator
      def self.create(profile)
        p "=========create =========="
        children_qtd = profile.max_recipient_children - profile.donations_children.size
        p "children qtd #{children_qtd}"
        return if children_qtd == 0

        if children_qtd > 0
          self.choose_children_for_donation(profile, children_qtd)
        else
          self.remove_children_for_donation(profile, children_qtd)
        end
      end

      def self.choose_children_for_donation(profile, children_qtd)
        children = self.recipient_children(children_qtd)
        p "=====children size #{children.size}"
        children.each do |child|
          child.update_attributes(donor_id: profile.id, was_recipient_until: nil)
          p "===errors  #{child.errors.full_messages}"
          self.send_message_to_donated child
        end
      end

      def self.remove_children_for_donation(profile, children_qtd)
        limit = children_qtd.abs
        children = profile.donations_children.limit(limit)
        children.update_all(donor_id: nil, was_recipient_until: DateTime.now)
      end

      def self.recipient_children(limit)
        priotity_profiles = profiles_with_priority(limit)
        was_recipient_children = Child.completed_profile.recipients(priotity_profiles)
                                      .was_recipient(limit)
                                      .to_a
        p "=======was_recipient_children #{was_recipient_children.size}"
        limit = limit - was_recipient_children.size
        p "=====limit #{limit}"

        children = Child.completed_profile.recipients(priotity_profiles)
                        .was_not_recipient(limit)
                        .to_a
        p "=======was_recipient_children #{children.size}"

        was_recipient_children.concat children
      end

      def self.send_message_to_donated(child)
        # if child.was_recipient_until.present?
        #   MessageDeliveries::ZenviaSmsSender.send(
        #                            child.profile.cell_phone_numbers,
        #                            Engine.first.warning_message_donated )
        # end
        # unless child.was_recipient_until.present?
        #   MessageDeliveries::ZenviaSmsSender.send(
        #                  child.profile.cell_phone_numbers,
        #                  Engine.first.welcame_message )
        # end
      end

      def self.profiles_with_priority(limit)
        # unauthorized_receive_sms_profiles = User.unauthorized_receive_sms.pluck('profiles.id')
        authorized_receive_sms_profiles = User.authorized_receive_sms.pluck('profiles.id').last(limit)
        # unauthorized_receive_sms_profiles.concat(authorized_receive_sms_profiles).first(limit)
      end

    end
  end
end
