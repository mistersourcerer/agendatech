#encoding:UTF-8
require "spec_helper"

describe Mailer do

  fixtures(:eventos)
  it "deve gerar email de criação de eventos" do
    evento = eventos(:qcon)
    # Send the email, then test that it got queued
    email = Mailer.email_de_criacao_de_evento(evento).deliver

    ActionMailer::Base.deliveries.should_not be_empty
    email.from.should eql Agendatech.mailer_from
    email.to.should eql Agendatech.mailer_to
  end

  fixtures(:grupos)
  it "deve gerar email de criação de grupos" do
    grupo = grupos(:one)
    # Send the email, then test that it got queued
    email = Mailer.email_de_criacao_de_grupo(grupo).deliver

    ActionMailer::Base.deliveries.should_not be_empty
    email.from.should eql Agendatech.mailer_from
    email.to.should eql Agendatech.mailer_to
  end

  fixtures(:contatos)
  it "deveria enviar um email" do
    contato = contatos(:albie)
    email = Mailer.email_de_contato(contato).deliver
    ActionMailer::Base.deliveries.empty?.should be_false
  end
end
