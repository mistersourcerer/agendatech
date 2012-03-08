class QuaseUmGadget
  def initialize(evento,tipo)
    @evento = evento
    @tipo = tipo
  end
  
  def associa(user)    
    if user.tem_gadget? @evento,@tipo
      gadget = user.gadget_para @evento,@tipo
    else
      gadget = Gadget.create :tipo => @tipo, :evento_id => @evento.id, :user_id => user.id
    end
    gadget
  end
end
