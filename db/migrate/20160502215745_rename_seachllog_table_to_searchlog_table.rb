class RenameSeachllogTableToSearchlogTable < ActiveRecord::Migration
  def change
    rename_table :searchllogs, :searchlogs
  end
end
