class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.boolean :authorize_receive_sms, default: false

      t.timestamps
    end
  end
end
