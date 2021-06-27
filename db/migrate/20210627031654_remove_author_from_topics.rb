class RemoveAuthorFromTopics < ActiveRecord::Migration[5.2]
  def change
    remove_column :topics, :images, :json
  end
end
