class AddfechatoInforme < ActiveRecord::Migration
  def change
  add_column :informes, :fecha, :datetime	
  end
end
