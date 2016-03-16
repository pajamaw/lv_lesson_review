class RemoveRatableTypeFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :ratable_type, :string
  end
end
