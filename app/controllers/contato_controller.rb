class ContatoController < ApplicationController
  
  def contato
    contato = Contato.new params[:contato]
    Mailer.email_de_contato(contato).deliver
    flash[:notice] = "Email enviado com sucesso. Obrigado!"
    redirect_to :controller => 'contato'
  end

end
