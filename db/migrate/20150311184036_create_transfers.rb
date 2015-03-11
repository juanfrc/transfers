class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :amount, null: false
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end
  end
end
