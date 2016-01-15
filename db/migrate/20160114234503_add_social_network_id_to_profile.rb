class AddSocialNetworkIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :social_network_id, :string
  end
end
