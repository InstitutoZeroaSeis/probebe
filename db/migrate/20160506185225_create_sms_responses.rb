class CreateSmsResponses < ActiveRecord::Migration
  def change
    create_table :sms_responses do |t|
      t.references :donor, index: true
      t.references :recipient, index: true

      t.timestamps
    end
  end
end
