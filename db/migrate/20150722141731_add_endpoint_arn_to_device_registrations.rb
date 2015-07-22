class AddEndpointArnToDeviceRegistrations < ActiveRecord::Migration
  def change
    add_column :device_registrations, :endpoint_arn, :string
  end
end
