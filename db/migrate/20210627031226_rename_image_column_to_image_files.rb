class RenameImageColumnToImageFiles < ActiveRecord::Migration[5.2]
  def change
    rename_column :image_files, :image, :images
  end
end
