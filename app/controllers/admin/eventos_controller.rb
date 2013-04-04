class Admin::EventosController < ApplicationController
  require "rubygems"
  require "twitter"

  before_filter :authenticate_admin!
  uses_tiny_mce :only => [:editar]

  def index
    @eventos = Evento.all(:conditions=>{:aprovado=>false})
    @eventos_editar = Evento.all
  end

  def editar
    @evento = Evento.find_by_cached_slug(params[:id])
  end

  def copiar
    evento_cadastrado = Evento.find_by_cached_slug(params[:id])
    @evento = Evento.new
    @evento.attributes = evento_cadastrado.attributes
    render 'eventos/new'
  end

  def update
    @evento = Evento.find_by_cached_slug(params[:id])
    if @evento.update_attributes(params[:evento])
      @evento.atualiza_tags(params[:tag_list][:tag_list])
      flash[:notice] = "Evento editado com sucesso"
      redirect_to :action => "index"
    else
      render :action => 'edit'
    end
  end

  def aprovar
    evento = Evento.find_by_cached_slug(params[:id])
    evento.aprova!
    begin
      twitter = Twitter::Client.new
      twitter.update("#{evento.nome} #agendatech #{evento_url(:ano => evento.data.year,:id=>evento)}")
    rescue Exception => e
      logger.warn(e.message)
    end
    flash[:notice] = "Evento aprovado."
    redirect_to :action => 'index'
  end

  def desaprovar
    evento = Evento.find_by_cached_slug(params[:id])
    evento.desaprova!
    flash[:notice] = "Evento desaprovado."
    redirect_to :action => 'index'
  end

  def remover
    evento = Evento.find_by_cached_slug(params[:id])
    evento.delete
    flash[:notice] = "Evento removido."
    redirect_to :action => 'index'
  end
end
