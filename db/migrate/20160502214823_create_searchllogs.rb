class CreateSearchllogs < ActiveRecord::Migration
  def change
    create_table :searchllogs do |t|
      t.string :text
      t.references :user, index: true

      t.timestamps
    end
  end
end
