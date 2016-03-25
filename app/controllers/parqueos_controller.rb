class ParqueosController < ApplicationController
  def new
    @parqueo = Parqueo.new
    @parqueo.automovil = Automovil.new
  end

  def create
    placa = params[:parqueo][:automovil][:placa]
    @parqueo = Parqueo.joins(:automovil).where(automoviles: { placa: placa }).order(hora_entrada: :desc).first

    if @parqueo.nil?
      @parqueo = Parqueo.new
      @parqueo.automovil = Automovil.new
      @parqueo.errors.add(:placa, "El automóvil identificado con la placa #{placa} no tiene registro de entrada")
    else
      if @parqueo.hora_salida.nil?
        @parqueo.hora_salida = Time.now
        @parqueo.update(valor_servicio: @parqueo.calcular_servicio)
      else
        @parqueo.errors.add(:placa, "El automóvil identificado con la placa #{placa} ya tiene registro de salida")
      end
    end

    render 'new'
  end
end
