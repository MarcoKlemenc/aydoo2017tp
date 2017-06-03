require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorcalendario'

describe 'GestorCalendario' do
  
  let(:gestor) { GestorCalendario.new }

  it 'es posible agregar un calendario al gestor' do
    calendario = Calendario.new "Un calendario"
    gestor.agregarCalendario(calendario)
    expect(gestor.calendarios["Un calendario"]).to eq calendario
  end
  
  it 'es posible agregar mas de un calendario al gestor' do
    unCalendario = Calendario.new "Un calendario"
    otroCalendario = Calendario.new "Otro calendario"
    gestor.agregarCalendario(unCalendario)
    gestor.agregarCalendario(otroCalendario)
    expect(gestor.calendarios.size).to eq 2
  end
  
  it 'no es posible agregar dos calendarios con el mismo nombre' do
    unCalendario = Calendario.new "Un calendario"
    calendarioRepetido = Calendario.new "Un calendario"
    gestor.agregarCalendario(unCalendario)
    expect{gestor.agregarCalendario(calendarioRepetido)}.to raise_error
  end

end
