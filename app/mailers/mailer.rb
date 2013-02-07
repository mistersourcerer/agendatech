class Mailer < ActionMailer::Base
  default from: Agendatech.mailer_from

  def email_de_criacao_de_evento(evento)
    @evento = evento
    mail(:to => Agendatech.mailer_to, :subject => "Novo evento #{@evento.nome} cadastrado")
  end

  def email_de_criacao_de_grupo(grupo)
    @grupo = grupo
    mail(:to => Agendatech.mailer_to, :subject => "Novo grupo #{@grupo.nome} cadastrado")
  end

  def email_de_contato(contato)
    @contato = contato
    mail(:to => Agendatech.mailer_to, :subject => "Contato agendatech")
  end
end
