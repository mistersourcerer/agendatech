# encoding: utf-8
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :tag_cloud, :twitter_search, :evento_destaque
  helper_method :meses, :numero_do_mes, :estados, :nome_do_estado

  protected
  def meses
    {
      "Janeiro" => 1,
      "Fevereiro" => 2,
      "Março" => 3,
      "Abril" => 4,
      "Maio" => 5,
      "Junho" => 6,
      "Julho" => 7,
      "Agosto" => 8,
      "Setembro" => 9,
      "Outubro" => 10,
      "Novembro" => 11,
      "Dezembro" => 12
    }
  end

  def numero_do_mes (mes)
    meses[mes]
  end

  def estados
    {
    "AC" =>   "Acre"  ,
    "AL" =>   "Alagoas"  ,
    "AP" =>   "Amapá"  ,
    "AM" =>   "Amazonas"  ,
    "BA" =>   "Bahia"  ,
    "CE" =>   "Ceará"  ,
    "DF" =>   "Distrito Federal"  ,
    "GO" =>   "Goiás"  ,
    "ES" =>   "Espírito Santo"  ,
    "MA" =>   "Maranhão"  ,
    "MT" =>   "Mato Grosso"  ,
    "MS" =>   "Mato Grosso do Sul"  ,
    "MG" =>   "Minas Gerais"  ,
    "PA" =>   "Pará"  ,
    "PB" =>   "Paraiba"  ,
    "PR" =>   "Paraná"  ,
    "PE" =>   "Pernambuco"  ,
    "PI" =>   "Piauí"  ,
    "RJ" =>   "Rio de Janeiro"  ,
    "RN" =>   "Rio Grande do Norte"  ,
    "RS" =>   "Rio Grande do Sul"  ,
    "RO" =>   "Rondônia"  ,
    "RR" =>   "Rorâima"  ,
    "SP" =>   "São Paulo"  ,
    "SC" =>   "Santa Catarina"  ,
    "SE" =>   "Sergipe"  ,
    "TO" =>   "Tocantins"
    }
  end

  # waiting peaceful for my refactor...
  def nome_do_estado (sigla)
    estados[sigla]
  end


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private

  def tag_cloud
    @tags = Evento.tag_counts_on(:tags)
  end

  def twitter_search
    @ultimos_comentarios = Comentario.ultimos

    eventos = Evento.ultimos_twitados
    @twits = []

    eventos.each do |e|
      if e.twitter_hash && !e.twitter_hash == ""
        Twitter::Search.new.q(e.twitter_hash).page(1).per_page(1).each do |r|
          @twits << r
        end
      end
    end
    @twits
  end

  def evento_destaque
    @banners = Banner.liberados
  end


end

