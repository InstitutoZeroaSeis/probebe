class AddDonorIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :donor_id, :integer, index: true
  end
end
