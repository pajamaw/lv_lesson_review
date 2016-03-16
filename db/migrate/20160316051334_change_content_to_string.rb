class ChangeContentToString < ActiveRecord::Migration
  def change
    change_column :comments, :content, :string
  end
end
