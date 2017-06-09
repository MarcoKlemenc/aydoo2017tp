require_relative './exception_calendario_existente'
require_relative './exception_calendario_no_encontrado'
require_relative './formateador_json'
require_relative './gestor_archivos'
require_relative './calendario'
require 'json'

class GestorCalendarios
  attr_reader :calendarios
  
  def leer_de_archivo
    gestor_archivos = GestorArchivos.new
    restablecer
    lineas = gestor_archivos.leer("calendarios.json")
    interpretado = FormateadorJson.interpretar(lineas)
    interpretado.each do |i|
      agregar_calendario(i["nombre"])
    end
  end
  
  def restablecer
    @calendarios = Hash.new
  end
  
  def initialize
    leer_de_archivo
  end
  
  def escribir_en_archivo
    gestor_archivos = GestorArchivos.new
    gestor_archivos.escribir(obtener_calendarios, "calendarios.json")
  end
  
  def agregar_calendario(nombre)
    nombre_minusculas = nombre.downcase
    raise ExceptionCalendarioExistente if @calendarios[nombre_minusculas]
    @calendarios[nombre_minusculas] = Calendario.new nombre
    escribir_en_archivo
  end
  
  def obtener_calendario(nombre)
    calendario = calendarios[nombre.downcase]
    raise ExceptionCalendarioNoEncontrado if calendario.nil?
    return FormateadorJson.formatear_objeto(calendario)
  end
  
  def obtener_calendarios
    return FormateadorJson.formatear_coleccion(calendarios.values)
  end
  
  def borrar_calendario(nombre)
    nombre_minusculas = nombre.downcase
    raise ExceptionCalendarioNoEncontrado if @calendarios[nombre_minusculas].nil?
    @calendarios.delete(nombre_minusculas)
    escribir_en_archivo
  end
  
end
