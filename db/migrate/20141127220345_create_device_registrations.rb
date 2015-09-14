class CreateDeviceRegistrations < ActiveRecord::Migration
  def change
    create_table :device_registrations do |t|
      t.string :platform
      t.string :platform_code
      t.references :profile

      t.timestamps
    end
  end
end
