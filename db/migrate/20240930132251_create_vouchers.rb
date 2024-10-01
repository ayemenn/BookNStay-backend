class CreateVouchers < ActiveRecord::Migration[7.1]
  def change
    create_table :vouchers do |t|
      t.string :name
      t.integer :discount_percentage
      t.decimal :min_amount

      t.timestamps
    end
  end
end
