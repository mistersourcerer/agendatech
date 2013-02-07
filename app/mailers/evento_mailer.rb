class EventoMailer < ActionMailer::Base
  default from: Agendatech.mailer_from

  def email_de_criacao_de_evento(evento)
    @evento = evento
    mail(:to => Agendatech.mailer_to, :subject => "#{@evento.nome} cadastrado")
  end
end
