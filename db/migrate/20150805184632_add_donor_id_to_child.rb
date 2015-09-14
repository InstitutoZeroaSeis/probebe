class AddDonorIdToChild < ActiveRecord::Migration
  def change
    add_column :children, :donor_id, :integer, index: true
  end
end
