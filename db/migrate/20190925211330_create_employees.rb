class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.float :wage
      t.string :hours
    end
  end
end
