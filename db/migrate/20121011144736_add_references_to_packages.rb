class AddReferencesToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :original_package_id, :integer
  end
end