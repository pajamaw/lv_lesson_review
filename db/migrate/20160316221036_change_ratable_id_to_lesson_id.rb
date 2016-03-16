class ChangeRatableIdToLessonId < ActiveRecord::Migration
  def change
    rename_column :ratings, :ratable_id, :lesson_id
  end
end
