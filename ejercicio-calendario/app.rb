require 'sinatra' 
require_relative 'model/gestor_archivos'
require_relative 'model/calendario'
require_relative 'model/evento'
require_relative 'model/formateador_json'
require_relative 'model/exception_calendario_existente'
require_relative 'model/exception_calendario_sin_nombre'

archivo_calendarios = "calendarios.json"
archivo_eventos = "eventos.json"
Calendario.batch(FormateadorJson.interpretar(GestorArchivos.leer(archivo_calendarios)))
Evento.batch(FormateadorJson.interpretar(GestorArchivos.leer(archivo_eventos)))

get  '/calendarios' do
  calendarios = Calendario.calendarios.values
  salida = FormateadorJson.formatear_coleccion(calendarios)
  "<pre>#{salida}</pre>"
end

post '/calendarios' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    Calendario.new entrada['nombre']
    calendarios = Calendario.calendarios.values
    salida = FormateadorJson.formatear_coleccion(calendarios)
    GestorArchivos.escribir(salida, archivo_calendarios)
    status 201
  rescue ExceptionCalendarioExistente, ExceptionCalendarioSinNombre
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    Calendario.calendarios.delete(params[:nombre].downcase) { |k| fail KeyError, k }
    calendarios = Calendario.calendarios.values
    salida = FormateadorJson.formatear_coleccion(calendarios)
    GestorArchivos.escribir(salida, archivo_calendarios)
  rescue KeyError
    status 404
  end
end

get '/calendarios/:nombre' do
  begin
    calendario = Calendario.calendarios.fetch(params[:nombre].downcase)
    salida = FormateadorJson.formatear_objeto(calendario)
    "<pre>#{salida}</pre>"
  rescue KeyError
    status 404
  end
end

post '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    Evento.new(entrada['calendario'], entrada['id'], entrada['nombre'], entrada['inicio'], entrada['fin'])
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    GestorArchivos.escribir(salida, archivo_eventos)
    status 201
  rescue ExceptionEventoSinId, ExceptionEventoExistente
    status 400
  end
end

delete '/eventos/:id' do
  begin
    Evento.eventos.delete(params[:id]) { |k| fail KeyError, k }
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    GestorArchivos.escribir(salida, archivo_eventos)
  rescue KeyError
    status 404
  end
end

put '/eventos' do
  begin
    entrada = FormateadorJson.interpretar([request.body.read])
    evento = Evento.eventos.fetch(entrada['id'])
    evento.actualizar(entrada['inicio'], entrada['fin'])
    eventos = Evento.eventos.values
    salida = FormateadorJson.formatear_coleccion(eventos)
    GestorArchivos.escribir(salida, archivo_eventos)
  rescue KeyError
    status 404
  end
end

get '/eventos' do
  eventos = Evento.eventos.values
  salida = FormateadorJson.formatear_coleccion(eventos)
  "<pre>#{salida}</pre>"
end

get '/eventos/:id' do
  begin
    evento = Evento.eventos.fetch(params[:id])
    salida = FormateadorJson.formatear_objeto(evento)
    "<pre>#{salida}</pre>"
  rescue KeyError
    status 404
  end
end
