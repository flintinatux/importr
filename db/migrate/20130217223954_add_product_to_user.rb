class AddProductToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :product
    end
  end
end
