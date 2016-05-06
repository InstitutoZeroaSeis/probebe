class DropTableMicrodonationSmsLogs < ActiveRecord::Migration
  def change
    drop_table :microdonation_sms_logs
  end
end
