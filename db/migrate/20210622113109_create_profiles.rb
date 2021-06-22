class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :image
      t.string :hobby
      t.string :greeting

      t.timestamps
    end
  end
end
