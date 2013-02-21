#encoding: utf-8
class EventosController < ApplicationController
  uses_tiny_mce :only => [:new,:create]

  def tenta_marcar_gadget
    if session[:quase_um_gadget] && current_user
      quase_um_gadget = session[:quase_um_gadget]
      quase_um_gadget.associa current_user
      session[:quase_um_gadget] = nil
    end
  end
  private :tenta_marcar_gadget

  def index
    tenta_marcar_gadget
    if params[:month]
      @eventos = Evento.por_mes(numero_do_mes(params[:month])).top_gadgets
    else
      if params[:estado]
        @eventos = Evento.por_estado(estados.key(params[:estado])).top_gadgets
      else
        @eventos = Evento.que_ainda_vao_rolar
      end
    end
  end

  def cursos
    @eventos = Evento.que_ainda_vao_rolar(TipoEvento::CURSO)
    render :action => 'index'
  end

  def new
    @evento = Evento.new
  end

  def create
    @evento = Evento.new(params[:evento])
    @evento.aprovado = false
    unless @evento.data_termino?
      @evento.data_termino = @evento.data
    end
    if @evento.save
      Mailer.email_de_criacao_de_evento(@evento).deliver
      flash[:aguarde] = "Obrigado! Seu evento aparecerá na lista em instantes!"
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def show
    @evento = Evento.find_by_cached_slug(params[:id])
    @comentario = Comentario.new
  end

  def tag
    @eventos = Evento.tagged_with(params[:id], :any => true)
    @tag = params[:id]
    render :action => "index"
  end
  
  def lista
    @participantes = []
    evento = Evento.find_by_cached_slug(params[:id])
    evento.gadgets.each do |g|
      begin
        @participantes << User.find(g.user_id).nickname
      rescue
        @participantes << "Twitter nao encontrado => #{g.user_id}"
      end
    end
  end
  
end
