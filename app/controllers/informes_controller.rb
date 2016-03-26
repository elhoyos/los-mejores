class InformesController < ApplicationController

 def index
 @informe=Informe.all
 end
 
 def show
 @informe=Informe.find(params[:id])
 end 
 def new
  @informe=Informe.new
  @informe.num_autos_parqueados = Parqueo.count(:hora_salida)
  @informe.num_autos_inscritos = Automovil.where(inscrito: true).count
  @informe.total_recaudo = Parqueo.sum("valor_servicio").to_i
  @informe.fecha = Time.new 
   
 end
 
 def create
 
 @informe=Informe.new(informe_params)
 @informe.save
 redirect_to @informe
 end
 
 private
  def informe_params
    params.require(:informe).permit(:num_autos_parqueados,:num_autos_inscritos,:total_recaudo,:fecha)
  end
end
