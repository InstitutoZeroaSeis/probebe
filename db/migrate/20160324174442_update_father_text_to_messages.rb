class UpdateFatherTextToMessages < ActiveRecord::Migration
  def change
    Message.all.each do |message|
      message.father_text = message.text
      message.save
    end
  end
end
