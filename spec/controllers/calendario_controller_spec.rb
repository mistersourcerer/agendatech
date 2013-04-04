require 'spec_helper'

describe CalendarioController do

  it "deveria adicionar os todos os eventos ao calendario" do
    pending "tem que fazer um assertion se o body da resposta eh o esperado, mockar o all do Active Record nao eh (mais?) uma boa ideia"
    hoje = Date.today

    qcon = Evento.create nome: "evento",
      descricao: "desc",
      site: "http://www.example.com",
      data: hoje,
      estado: 'BA',
      aprovado: true,
      data_termino: hoje + 1

    qcon.should_receive(:data).exactly(3).times.and_return(hoje)
    qcon.should_receive(:data_termino).exactly(3).times.and_return(hoje)
    qcon.should_receive(:nome).and_return('Qcon')
    qcon.should_receive(:descricao).and_return('descrevendo')

    get 'index'
  end

  it "deveria adicionar os todos os eventos do estado ao calendario" do
    qcon = mock_model(Evento)
    qcon.should_receive(:data).exactly(3).times.and_return(Time.now)
    qcon.should_receive(:data_termino).exactly(3).times.and_return(Time.now)
    qcon.should_receive(:nome).and_return('Qcon')
    qcon.should_receive(:descricao).and_return('descrevendo')
    eventos = []
    eventos << qcon
    Evento.should_receive(:por_estado).with('BA').and_return(eventos)
    get 'index',:estado => 'Bahia'
  end  

end
