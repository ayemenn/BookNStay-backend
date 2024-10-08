class AddVoucherToPayments < ActiveRecord::Migration[7.1]
  def change
    add_reference :payments, :voucher, foreign_key: true
  end
end
