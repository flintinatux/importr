class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date    :date,        null: false
      t.money   :amount,      null: false
      t.string  :description
      t.integer :user_id,     null: false

      t.timestamps
    end
  end
end
