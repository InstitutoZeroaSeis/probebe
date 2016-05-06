class DropTableMicrodonationSmsLogs < ActiveRecord::Migration
  def change
    drop_table :microdonation_sms_logs if ActiveRecord::Base.connection.table_exists? 'microdonation_sms_logs'
  end
end
