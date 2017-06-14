require_relative './exception_calendario_sin_nombre'
require_relative './exception_calendario_existente'
require_relative './exception_evento_superpuesto'
require_relative './exception_evento_repetido'

class Calendario
  @@calendarios = {}
  attr_reader :nombre
  attr_accessor :eventos

  def initialize(nombre)
    raise ExceptionCalendarioSinNombre if nombre == ""
    raise ExceptionCalendarioExistente if @@calendarios[nombre.downcase]
    @nombre = nombre
    @eventos = {}
    @@calendarios[nombre.downcase] = self
  end

  def agregar_evento(evento)
    validar_nombre_evento(evento.nombre)
    validar_superposicion(evento.inicio, evento.fin, evento.id)
    @eventos[evento.id] = evento
  end

  def self.batch(lista)
    lista.each do |l|
      Calendario.new l['nombre']
    end
  end

  def self.calendarios
    @@calendarios
  end

  def validar_nombre_evento(nombre)
    eventos.values.each do |e|
      raise ExceptionEventoRepetido if e.nombre == nombre
    end
  end

  def validar_superposicion(inicio, fin, id)
    fecha_hora_inicio = DateTime.parse(inicio)
    fecha_hora_fin = DateTime.parse(fin)
    @eventos.values.each do |e|
      inicio_a_comparar = DateTime.parse(e.inicio)
      fin_a_comparar = DateTime.parse(e.fin)
      raise ExceptionEventoSuperpuesto if fecha_hora_inicio.between?(inicio_a_comparar, fin_a_comparar) && e.id != id
      raise ExceptionEventoSuperpuesto if fecha_hora_fin.between?(inicio_a_comparar, fin_a_comparar) && e.id != id
    end
  end

  def eliminar_eventos
    Evento.class_variable_set :@@eventos, Evento.eventos.delete_if {|k, v| Evento.eventos.key?(k)}
    @eventos = {}
  end

  def to_h
    return {"nombre" => @nombre}
  end

end
