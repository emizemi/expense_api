class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :price
      t.integer :quantity
      t.datetime :date

      t.timestamps
    end
  end
end
