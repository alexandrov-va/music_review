class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :title
      t.text :description
      t.string :release_year
      t.string :artist

      t.timestamps null: false
    end
  end
end
