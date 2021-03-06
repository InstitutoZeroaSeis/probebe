class FixRetroactiveMessages < ActiveRecord::Migration
  def change
    Child.where("created_at like ?","#{Date.new(2016,02,11)}%").each do |child|
      child.message_deliveries.destroy_all
      if child.message_deliveries.empty?
        RetroactiveMessagesWorker.perform_async(Date.today, child.id)
      end
    end
  end
end
