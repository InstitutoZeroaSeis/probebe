class AddPictureIdToSiteCoordenatorsPage < ActiveRecord::Migration
  def change
    add_column :site_coordinators_pages, :picture_id, :integer
  end
end
