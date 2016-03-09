class RemoveCreatedEndJobAtManagerMessages < ActiveRecord::Migration
  def change
     remove_column :message_deliveries_manager_message_deliveries, :creator_jobs_end
  end
end
