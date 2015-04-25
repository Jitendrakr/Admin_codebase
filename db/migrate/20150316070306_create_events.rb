class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :link
      t.text :description
      t.boolean :show
      t.string :event_type

      t.timestamps
    end
  end
end
