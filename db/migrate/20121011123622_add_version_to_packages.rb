class AddVersionToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :version, :string
  end
end