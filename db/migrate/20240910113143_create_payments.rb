class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.decimal :total_amount
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
