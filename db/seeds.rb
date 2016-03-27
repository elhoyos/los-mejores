# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Parqueo.delete_all
Automovil.delete_all
Informe.delete_all
Usuario.delete_all

automoviles = Automovil.create([
  { placa: "MLC089", inscrito: false },
  { placa: "LLC454", inscrito: true },
  { placa: "DUV777", inscrito: false }
])

Parqueo.create([
  {
    automovil: automoviles.first,
    hora_entrada: Time.new(2016, 02, 22, 10, 00, 00),
    hora_salida: Time.new(2016, 02, 22, 11, 00, 00),
    valor_servicio: 2000
  },
  {
    automovil: automoviles.first,
    hora_entrada: Time.new(2016, 03, 22, 10, 00, 00)
  }
])

Parqueo.create(
  automovil: automoviles.second,
  hora_entrada: Time.new(2016, 03, 22, 10, 00, 00)
)

Parqueo.create([
  automovil: automoviles.third,
  hora_entrada: Time.new(2016, 02, 22, 10, 00, 00),
  hora_salida: Time.new(2016, 02, 22, 11, 00, 00),
  valor_servicio: 2000
])

Usuario.create(nombre: 'Gerente', email: 'gerente@losmejores.com', password: 'gerente', password_confirmation: 'gerente')
Usuario.create(nombre: 'Operador', email: 'operador@losmejores.com', password: 'operador', password_confirmation: 'operador')