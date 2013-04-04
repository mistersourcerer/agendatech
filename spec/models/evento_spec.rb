#encoding: utf-8
require 'spec_helper'

describe Evento do

    before do
       @evento1 = Evento.create :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'BA',:aprovado => true
       @evento2 = Evento.create :nome => "evento1", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'BA',:aprovado => true
       @evento3 = Evento.create :nome => "evento2", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'SP',:aprovado => true
       @curso = Evento.create :nome => "evento2", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'SP',:aprovado => true,:tipo_evento => TipoEvento::CURSO
       @evento_de_outro_ano = Evento.create :nome => "evento2", :descricao => "desc", :site => "http://www.example.com", :data => '10/10/2006', :estado => 'SP',:aprovado => true

       g1 = Gadget.new :tipo => Gadget.tipos[:eu_vou][:nome], :evento_id => @evento1.id, :user_id => 1
       g1.save!

       g2 = Gadget.new :tipo => 'promocao', :evento_id => @evento1.id, :user_id => 1
       g2.save!

       g3 = Gadget.new :tipo => 'promocao', :evento_id => @evento1.id, :user_id => 1
       g3.save!
    end

    describe "aprovação" do
         it "deve aprovar um evento" do
           evento_nao_aprovado = Evento.create :nome => "evento nao aprovado", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'RJ',:aprovado => false

           evento_nao_aprovado.aprova!

           evento_nao_aprovado.aprovado.should be_true
         end

         it "deve desaprovar um evento" do
           evento_aprovado = Evento.create :nome => "evento nao aprovado", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'RJ',:aprovado => true

           evento_aprovado.desaprova!

           evento_aprovado.aprovado.should be_false
         end
    end

  describe "validando as datas" do

    before do
       @data_base = Date.today
       @evento = Evento.new :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => @data_base
    end

    it "deveria validar a data de inicio apenas para eventos não aprovados" do
      #por algum motivo, o qual desconheco :), nao ta rolando garantir so ano com 4 digitos. Mesmo assim o plugin
      #ainda ta pegando certo.
      @evento.data = "10/13/10"
      @evento.should_not be_valid
      @evento.aprovado = true
      @evento.should be_valid
    end

    it "deveria validar a data de termino apenas para eventos não aprovados" do
        @evento.data_termino = "10/13/10"
        @evento.should_not be_valid
        @evento.aprovado = true
        @evento.should be_valid
    end


    it "deveria falar que o evento esta rolando se a data de termino eh vazia e o dia eh hoje" do
      @evento.data_termino = nil
      @evento.should be_ta_rolando
    end

    it "deveria verificar que a data de termino é posterior a data de inicio" do
      @evento.data_termino = @evento.data - 1.day
      @evento.should_not be_valid
      @evento.data_termino = @evento.data + 1.day
      @evento.should be_valid
    end

    it "deveria verificar se o dia está no intervalo do de dias do evento" do
      @evento.data = Date.today
      @evento.data_termino = Date.today + 2.day
      @evento.should be_ta_rolando
      @evento.data = Date.today + 4.day
      @evento.data_termino = Date.today + 6.day
      @evento.should_not be_ta_rolando
    end
  end

  describe "listagens dos eventos aprovados" do
    it "deveria listar os eventos que vao rolar por algum tipo diferente de conferencia" do
      Evento.que_ainda_vao_rolar(TipoEvento::CURSO).length.should eq(1)
    end

      it "que ainda vao ocorrer" do
          Evento.que_ainda_vao_rolar.length.should eq(3)
      end

      it "do mes" do
          Evento.por_mes(Date.today.month).length.should eq(3)
      end

      it "por estado" do
          Evento.por_estado('SP').length.should eq(1)
      end

      it "com os gadgets de algum tipo" do
          Evento.que_ainda_vao_rolar.top_gadgets.length.should eq(3)
      end

      it "agrupados por estados" do
         estados = Evento.agrupado_por_estado
         estados.size.should eq(2)
         estados.has_key?('BA').should be_true
      end

      it "agrupados por mes" do
         meses = Evento.agrupado_por_mes
         meses.size.should eq 1
         meses.has_key?(Date.today.month).should be_true
      end
  end

  describe "gadgets associados" do
    it "deveria pegar apenas os gadgets do tipo eu vou" do
      evento = Evento.find(@evento1.id)
      evento.me_da_gadgets.eu_vou.length.should eq(1)
    end

    it "deveria pegar apenas os gadgets do tipo promocao" do
      Evento.find_by_id(@evento1.id).me_da_gadgets.promocao.length.should eq(2)
    end
  end

end
