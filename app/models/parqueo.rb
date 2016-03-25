class Parqueo < ActiveRecord::Base
  belongs_to :automovil

  validates :hora_entrada, presence: true
  validates :hora_salida, presence: true, on: :update
  validates :valor_servicio, numericality: { greater_than: 0 }, on: :update

  def calcular_servicio
    1000
  end
end
