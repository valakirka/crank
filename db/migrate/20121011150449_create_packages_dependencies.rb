class CreatePackagesDependencies < ActiveRecord::Migration
  def up
    create_table :packages_dependencies, :force => true do |t|
      t.references :package
      t.integer :dependency_id
    end
  end

  def down
    drop_table :packages_dependencies
  end
end