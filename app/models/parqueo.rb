class Parqueo < ActiveRecord::Base
  belongs_to :automovil

  validates :hora_entrada, presence: true
  validates :hora_salida, presence: true, on: :update
  validates :valor_servicio, numericality: { greater_than: 0 }, on: :update

  COBRO_DIA = 20000
  COBRO_HORA = 2000
  COBRO_FRACCION_HORA = 500
  COBRO_MENSUALIDAD = 200000
  FRACCION_HORA = 15

  def calcular_servicio
    seconds = hora_salida - hora_entrada
    days = seconds / (24 * 60 * 60)
    hours = (days - days.to_i) * 24
    minutes = (hours - hours.to_i) * 60
    days = days.to_i
    hours = hours.to_i
    minutes = minutes.to_i

    logger.debug "Componentes del parqueo. #{days} días, #{hours} horas, #{minutes} minutos"

    valor_servicio = days * COBRO_DIA
    valor_horas = hours * COBRO_HORA

    if hours > 0
      valor_horas += (minutes / FRACCION_HORA.to_f).ceil * COBRO_FRACCION_HORA
    end

    if valor_horas > COBRO_DIA
      valor_servicio += COBRO_DIA
    else
      valor_servicio += valor_horas
    end

    logger.debug "Valor horas: #{valor_horas}"
    logger.debug "Valor del servicio: #{valor_servicio}"

    valor_servicio
  end
end
