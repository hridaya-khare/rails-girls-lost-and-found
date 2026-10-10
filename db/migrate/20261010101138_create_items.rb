class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :location
      t.date :happened_on
      t.boolean :resolved, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
