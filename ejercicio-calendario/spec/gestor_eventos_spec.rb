require 'rspec' 
require_relative '../model/gestor_eventos'

describe 'GestorEventos' do
  
  let(:gestor) { GestorEventos.new }

  it 'es posible agregar un evento al gestor' do
    id = "1"
    nombre = "Un evento"
    gestor.agregar_evento("Un calendario", id, nombre, "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00")
    expect(gestor.eventos[id].nombre).to eq nombre
  end
  
  it 'es posible obtener un evento del gestor' do
    id = "1"
    nombre = "Un evento"
    gestor.agregar_evento("Un calendario", id, nombre, "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00")
    salida = '{
  "calendario": "Un calendario",
  "id": "1",
  "nombre": "Un evento",
  "inicio": "2017-03-31T18:00:00-03:00",
  "fin": "2017-03-31T22:00:00-03:00"
}'
    expect(gestor.obtener_evento(id)).to eq salida
  end
  
  it 'es posible obtener todos los eventos del gestor' do
    gestor.agregar_evento("Un calendario", "1", "Un evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00")
    gestor.agregar_evento("Otro calendario", "2", "Otro evento", "2017-03-31T18:00:00-03:00", "2017-03-31T22:00:00-03:00")
    salida = '[
  {
    "calendario": "Un calendario",
    "id": "1",
    "nombre": "Un evento",
    "inicio": "2017-03-31T18:00:00-03:00",
    "fin": "2017-03-31T22:00:00-03:00"
  },
  {
    "calendario": "Otro calendario",
    "id": "2",
    "nombre": "Otro evento",
    "inicio": "2017-03-31T18:00:00-03:00",
    "fin": "2017-03-31T22:00:00-03:00"
  }
]'
    expect(gestor.obtener_eventos).to eq salida
  end
  
end
