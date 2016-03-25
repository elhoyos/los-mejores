class CreateInformes < ActiveRecord::Migration
  def change
    create_table :informes do |t|
      t.integer :num_autos_parqueados
      t.integer :num_autos_inscritos
      t.integer :total_recaudo
	  t.datetime :fecha_informe	
      t.timestamps null: false
    end
  end
end
