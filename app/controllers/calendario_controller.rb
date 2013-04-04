class CalendarioController < ApplicationController

  def index
    if params[:estado]
      @eventos = Evento.por_estado(estados.key(params[:estado]))
    else
      @eventos = Evento.all
    end

    @calendar = Icalendar::Calendar.new

    @eventos.each do |evento|
      @calendar.add icalendar_event_for(evento)
    end

    @calendar.publish
    render :layout => false, :text => @calendar.to_ical
  end

  def icalendar_event_for(evento)
    event = Icalendar::Event.new
    event.start = Date.new(evento.data.year, evento.data.month, evento.data.day) #evento.data
    event.end = Date.new(evento.data_termino.year, evento.data_termino.month, evento.data_termino.day) + 1 #evento.data_termino
    event.summary = evento.nome
    event.description = evento.descricao
    event
  end
  private :icalendar_event_for

  def links; end
end
