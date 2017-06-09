require 'rspec' 
require_relative '../model/calendario'

describe 'Calendario' do

  it 'es posible asignar un nombre a un calendario' do
    calendario = Calendario.new "Un calendario"
    expect(calendario.nombre).to eq "Un calendario"
  end
  
  it 'al crearse, el calendario se asigna a la coleccion' do
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    expect(Calendario.calendarios[nombre.downcase].nombre).to eq nombre
  end
  
  it 'es posible obtener el calendario como hash' do
    calendario = Calendario.new "Un calendario"
    hash = {"nombre" => "Un calendario",}
    expect(calendario.to_h).to eq hash
  end
  
  it 'no es posible agregar un calendario sin nombre' do
    expect{Calendario.new ""}.to raise_error(ExceptionCalendarioSinNombre)
  end

end
