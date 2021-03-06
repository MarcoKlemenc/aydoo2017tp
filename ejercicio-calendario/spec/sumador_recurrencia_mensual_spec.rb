require 'rspec'
require_relative '../model/sumador_recurrencia_mensual'

describe 'SumadorRecurrenciaMensual' do

  it 'es posible sumarle un mes a una fecha' do
    sumador = SumadorRecurrenciaMensual.new
    fecha_inicial = DateTime.new(2017, 5, 15, 15, 0, 0)
    fecha_esperada = DateTime.new(2017, 6, 15, 15, 0, 0)
    expect(sumador.sumar(fecha_inicial)).to eq fecha_esperada
  end

  it 'si el mes origen es mas largo, se usa el ultimo dia del mes destino' do
    sumador = SumadorRecurrenciaMensual.new
    fecha_inicial = DateTime.new(2017, 3, 31, 13, 0, 0)
    fecha_esperada = DateTime.new(2017, 4, 30, 13, 0, 0)
    expect(sumador.sumar(fecha_inicial)).to eq fecha_esperada
  end

end
