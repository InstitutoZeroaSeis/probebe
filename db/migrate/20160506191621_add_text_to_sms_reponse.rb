class AddTextToSmsReponse < ActiveRecord::Migration
  def change
    add_column :sms_responses, :text, :string
  end
end
