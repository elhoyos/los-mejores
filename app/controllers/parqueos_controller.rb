class ParqueosController < ApplicationController
  def new
    @parqueos = Parqueo.all.order(hora_entrada: :desc)
    @parqueo = Parqueo.new
    @parqueo.automovil = Automovil.new
  end

  def create
    placa = params[:parqueo][:automovil][:placa]
    automovil = Automovil.where(placa: placa).first

    if automovil.nil?
      @parqueo = Parqueo.new
      @parqueo.automovil = Automovil.new
      @parqueo.errors.add(:placa, "Debe indicar una placa")
    else
      @parqueo = Parqueo.joins(:automovil).where(hora_salida: nil, automoviles: { placa: placa }).first

      if @parqueo
        @parqueo.errors.add(:placa, "El automóvil identificado con la placa #{placa} ya tiene un registro de entrada sin salida")
      else
        @parqueo = Parqueo.new(parqueo_create_params)
        @parqueo.automovil = automovil
        if @parqueo.save
          return redirect_to action: :new
        end
      end
    end

    @parqueos = Parqueo.all.order(hora_entrada: :desc)
    render 'new'
  end

  def salida
    @parqueo = Parqueo.new
    @parqueo.automovil = Automovil.new
  end

  def salida_create
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

    render 'salida'
  end

  private
    def parqueo_create_params
      params.require(:parqueo).permit(:hora_entrada)
    end
end
