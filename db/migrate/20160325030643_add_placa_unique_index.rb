class AddPlacaUniqueIndex < ActiveRecord::Migration
  def change
    change_table :automoviles do |t|
      t.index :placa, unique: true
    end
  end
end
