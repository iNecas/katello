class UpdateRepositoriesContentIdAllowNull < ActiveRecord::Migration
  def up
    change_column :repositories, :content_id, :string, :null => true
  end

  def down
    change_column :repositories, :content_id, :string, :null => false
  end
end
