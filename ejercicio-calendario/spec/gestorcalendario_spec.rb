require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorcalendario'

describe 'GestorCalendario' do
  
  let(:gestor) { GestorCalendario.new }

  it 'es posible agregar un calendario al gestor' do
    gestor.restablecer
    calendario = Calendario.new "Un calendario"
    gestor.agregarCalendario(calendario)
    expect(gestor.calendarios["un calendario"]).to eq calendario
  end
  
  it 'es posible borrar un calendario existente' do
    gestor.restablecer
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    gestor.agregarCalendario(calendario)
    gestor.borrarCalendario(nombre)
    expect(gestor.calendarios.size).to eq 0
  end
  
  it 'es posible agregar mas de un calendario al gestor' do
    gestor.restablecer
    unCalendario = Calendario.new "Un calendario"
    otroCalendario = Calendario.new "Otro calendario"
    gestor.agregarCalendario(unCalendario)
    gestor.agregarCalendario(otroCalendario)
    expect(gestor.calendarios.size).to eq 2
  end
  
  it 'no es posible agregar dos calendarios con el mismo nombre' do
    gestor.restablecer
    unCalendario = Calendario.new "Un calendario"
    calendarioRepetido = Calendario.new "Un calendario"
    gestor.agregarCalendario(unCalendario)
    expect{gestor.agregarCalendario(calendarioRepetido)}.to raise_error
  end
  
  it 'no es posible agregar dos calendarios variando mayusculas' do
    gestor.restablecer
    unCalendario = Calendario.new "Un calendario"
    calendarioRepetido = Calendario.new "uN CalenDario"
    gestor.agregarCalendario(unCalendario)
    expect{gestor.agregarCalendario(calendarioRepetido)}.to raise_error
  end
  
  it 'es posible obtener un calendario como JSON' do
    gestor.restablecer
    nombre = "Un calendario"
    unCalendario = Calendario.new nombre
    gestor.agregarCalendario(unCalendario)
    salida =
    '{
  "nombre": "Un calendario"
}'
    expect(gestor.obtener_calendario(nombre)).to eq salida
  end
  
  it 'es posible obtener los calendarios como JSON' do
    gestor.restablecer
    unCalendario = Calendario.new "Un calendario"
    otroCalendario = Calendario.new "Otro calendario"
    gestor.agregarCalendario(unCalendario)
    gestor.agregarCalendario(otroCalendario)
    salida =
    '[
  {
    "nombre": "Un calendario"
  },
  {
    "nombre": "Otro calendario"
  }
]'
    expect(gestor.obtener_calendarios).to eq salida
  end
  
  it 'es posible leer un calendario de archivo' do
    gestor.restablecer
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    gestor.agregarCalendario(calendario)
    gestor.leer_de_archivo
    expect(gestor.calendarios[nombre.downcase].nombre).to eq nombre
  end
  
  it 'es posible escribir un calendario en archivo' do
    gestor.restablecer
    nombre = "Un calendario"
    calendario = Calendario.new nombre
    gestor.agregarCalendario(calendario)
    gestor.escribir_en_archivo
    salida = File.open("calendarios.json", &:readline)
    esperado = '[
'
    expect(salida).to eq esperado
  end

end
