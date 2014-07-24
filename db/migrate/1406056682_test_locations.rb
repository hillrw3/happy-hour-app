class TestLocations < ActiveRecord::Migration
  def up
    create_table :locations_test do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :phone
      t.string :address
    end
  end

  def down
    # add reverse migration code here
  end
end
