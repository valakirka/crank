class CreateMaintainers < ActiveRecord::Migration
  def change
    create_table :maintainers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
