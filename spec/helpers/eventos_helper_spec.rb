require 'spec_helper'

describe EventosHelper do

  it "deveria gerar uma url valida baseada no evento" do
    data = Date.today

    evento = Evento.new
    evento.nome = 'nome'
    evento.descricao = 'descricao'
    evento.site = 'http://www.teste.com.br'
    evento.data = data
    evento.save!

    helper.evento_full_path(evento).should == evento_path(:ano => data.year, :id => evento)
 end
 
 describe "agrupamentos de eventos" do
 
    it "deveria retornar os estados com numero de eventos e a somatoria de eventos" do
      Evento.should_receive(:agrupado_por_estado).and_return({"BA" => 2,"SP" => 1})
      estados,total = helper.estados_com_total_de_eventos
      estados.size.should eq 2
      total.should eq 3
    end
    
    it "deveria retornar os meses com numero de eventos e a somatoria de eventos do ano corrente" do
      Evento.should_receive(:agrupado_por_mes).and_return({12 => 2,10 => 4})
      meses,total = helper.meses_com_total_de_eventos
      meses.size.should eq 2
      meses[12].should eq 2
      total.should eq 6
    end
    
    #horrivel, mas nao tenho o que fazer #heroku
    it "deveria retornar os meses com numero de eventos e a somatoria de eventos do ano corrente versao heroku" do
      Evento.should_receive(:agrupado_por_mes).and_return({"12" => 2,"10" => 4})
      meses,total = helper.meses_com_total_de_eventos
      meses.size.should eq 2
      meses[12].should eq 2
      total.should eq 6
    end        
  end
  
  describe "imagem do twitter" do
  
    it "deveria pegar com link para a propria aplicacao" do
      helper.link_da_imagem_do_twitter_para("teste.png").should eq("twimages/teste.png")    
    end
    
    it "deveria pegar com link para o s3 caso o ambiente seja de producao" do
      Rails.env = 'production' 
      helper.link_da_imagem_do_twitter_para("teste.png").should eq("http://s3.amazonaws.com/twitter_images/teste.png")    
      Rails.env = 'test' 
    end    
    
    it "deveria pegar a do usuario associado ao comentario" do
      user = User.new(:nickname => "teste",:email => "teste@teste.com.br",:image => "http://a3.twimg.com/profile_images/1201901056/ic_launcher.png")
      User.should_receive(:por_login_social).with('teste').and_return(user)
      c = Comentario.new
      c.twitter = "teste"
      helper.user_pic_by(c).should eq("twimages/teste.png")    
    end
    
    it "deveria pegar a  do usuario associado ao comentario como link para o s3 caso o ambiente seja de producao" do
      Rails.env = 'production' 
      user = User.new(:nickname => "teste",:email => "teste@teste.com.br",:image => "http://a3.twimg.com/profile_images/1201901056/ic_launcher.png")
      User.should_receive(:por_login_social).with('teste').and_return(user)
      c = Comentario.new
      c.twitter = "teste"
      helper.user_pic_by(c).should eq("http://s3.amazonaws.com/twitter_images/teste.png")    
      Rails.env = 'test' 
    end  
    
    it "deveria pegar a padrao para comentarios anteriores, quando usuarios nao precisavam se logar" do
      User.should_receive(:por_login_social).with('teste').and_return(nil)
      c = Comentario.new
      c.twitter = "teste"
      helper.user_pic_by(c).should eq("twitter_usr_padrao.png")    
    end 
  
  end 


end
