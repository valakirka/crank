class CreateAuthorsPackages < ActiveRecord::Migration
  def up
    create_table :authors_packages do |t|
      t.references :author
      t.references :package
    end
  end

  def down
    drop_table :authors_packages
  end
end
