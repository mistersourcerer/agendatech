#encoding: utf-8
class GruposController < ApplicationController
  def index
    @grupos = Grupo.por_nome.aprovados
  end

  def show
    @grupo = Grupo.find params[:id], :include => :eventos
  end

  def new
    @grupo = Grupo.new
  end

  def tag
    @grupos = Grupo.tagged_with(params[:id], :any => true)
    @tag = params[:id]
    render :action => "index"
  end

  def create
    @grupo = Grupo.new(params[:grupo])

    if @grupo.save
      respond_to do |format|
        format.html do
          Mailer.email_de_criacao_de_grupo(@grupo).deliver
          flash[:aguarde] = 'Grupo registrado com sucesso. Seu grupo estará disponível em instantes.'
          redirect_to root_path
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Erro no cadastro do grupo, por favor verifique os erros.'
          render :new
        end
      end
    end
  end
end
