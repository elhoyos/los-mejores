class Parqueo < ActiveRecord::Base
  belongs_to :automovil

  validates :hora_entrada, presence: true
  validates :hora_salida, presence: true, on: :update
  validates :valor_servicio, numericality: { greater_than_or_equal_to: 0 }, on: :update

  COBRO_DIA = 20000
  COBRO_HORA = 2000
  COBRO_FRACCION_HORA = 500
  COBRO_MENSUALIDAD = 200000
  FRACCION_HORA = 15

  def calcular_servicio
    automovil.inscrito ? valor_servicio_inscrito : valor_servicio_no_inscrito
  end

  private
    def valor_servicio_inscrito
      meses_por_pagar = meses(hora_entrada, hora_salida)
      inicio_mes_entrada = hora_entrada.change(day: 1, hour: 0)
      pagos_anteriores = Parqueo.where("automovil_id = ? AND valor_servicio > 0 AND hora_entrada >= ?", automovil.id, inicio_mes_entrada)

      pagos_anteriores.each do |pago_anterior|
        meses_pagados = meses(pago_anterior.hora_entrada, pago_anterior.hora_salida)
        logger.debug "Pagos anteriores: #{meses_pagados.inspect}"
        meses_por_pagar = meses_por_pagar - meses_pagados
      end

      logger.debug "Meses por pagar: #{meses_por_pagar.inspect}"

      valor_servicio = meses_por_pagar.length * COBRO_MENSUALIDAD

      logger.debug "Valor del servicio: #{valor_servicio}"

      valor_servicio
    end

    def valor_servicio_no_inscrito
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

    def meses(entrada, salida)
      (entrada.to_datetime..salida.to_datetime).map{ |date| date.strftime("%m %Y") }.uniq
    end
end
