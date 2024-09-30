class CreateGuestinfos < ActiveRecord::Migration[7.1]
  def change
    create_table :guestinfos do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :number_of_adults
      t.integer :number_of_children

      t.timestamps
    end
  end
end
