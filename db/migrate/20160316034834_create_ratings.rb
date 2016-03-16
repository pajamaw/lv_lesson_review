class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :star_rating
      t.references :ratable, polymorphic: true

      t.timestamps null: false
    end
  end
end
