#encoding:UTF-8
require "spec_helper"

describe EventoMailer do

  fixtures(:eventos)
  it "deve gerar email de criação de eventos" do
    evento = eventos(:qcon)
    # Send the email, then test that it got queued
    email = EventoMailer.email_de_criacao_de_evento(evento).deliver

    ActionMailer::Base.deliveries.should_not be_empty
    email.from.should eql Agendatech.mailer_from
    email.to.should eql Agendatech.mailer_to
    
  end

end
