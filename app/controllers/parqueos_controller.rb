class ParqueosController < ApplicationController
  def new
    @parqueo = Parqueo.new
    @parqueo.automovil = Automovil.new
  end
end
