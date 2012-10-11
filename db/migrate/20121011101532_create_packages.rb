class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :r_version
      t.datetime :publication_date
      t.text :title
      t.text :description
      t.string :license

      t.timestamps
    end
  end
end
