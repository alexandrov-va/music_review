class AddMusicIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :music_id, :integer
  end
end
