require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/evento'

describe 'Calendario' do
  
  before(:each) { Calendario.class_variable_set :@@calendarios, Hash.new }

  it 'es posible asignar un nombre a un calendario' do
    calendario = Calendario.new "Un calendario"
    expect(calendario.nombre).to eq "Un calendario"
  end
  
  it 'el calendario se crea sin eventos' do
    calendario = Calendario.new "Un calendario"
    expect(calendario.eventos.size).to eq 0
  end
  
  it 'es posible agregar un evento' do
    calendario = Calendario.new "Un calendario"
    evento = Evento.new "Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00"
    calendario.agregar_evento(evento)
    expect(calendario.eventos["1"]).to eq evento
  end
  
  it 'es posible crear varios calendarios a partir de una lista de hashes' do
    hashes = [{"nombre" => "Un calendario"}, {"nombre" => "Otro calendario"}]
    Calendario.batch(hashes)
    expect(Calendario.calendarios.size).to eq 2
  end
  
  it 'al crearse, el calendario se asigna a la coleccion' do
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    expect(Calendario.calendarios[nombre.downcase]).to eq calendario
  end
  
  it 'es posible obtener el calendario como hash' do
    calendario = Calendario.new "Un calendario"
    hash = {"nombre" => "Un calendario",}
    expect(calendario.to_h).to eq hash
  end
  
  it 'no es posible agregar un calendario sin nombre' do
    expect{Calendario.new ""}.to raise_error(ExceptionCalendarioSinNombre)
  end
  
  it 'no es posible agregar un calendario con nombre repetido' do
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    expect{Calendario.new nombre}.to raise_error(ExceptionCalendarioExistente)
  end
  
  it 'no es posible agregar un calendario variando mayusculas' do
    calendario = Calendario.new "Un calendario"
    expect{Calendario.new "uN cAlEndArIO"}.to raise_error(ExceptionCalendarioExistente)
  end

end
