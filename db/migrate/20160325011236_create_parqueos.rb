class CreateParqueos < ActiveRecord::Migration
  def change
    create_table :automoviles do |t|
      t.string :placa
      t.boolean :inscrito

      t.timestamps null: false
    end

    create_table :parqueos do |t|
      t.belongs_to :automovil, index:true
      t.datetime :hora_entrada
      t.datetime :hora_salida
      t.decimal :valor_servicio

      t.timestamps null: false
    end
  end
end
