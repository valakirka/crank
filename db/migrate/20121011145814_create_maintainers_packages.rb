class CreateMaintainersPackages < ActiveRecord::Migration
  def up
    create_table :maintainers_packages do |t|
      t.references :maintainer
      t.references :package
    end
  end

  def down
    drop_table :maintainers_packages
  end
end
