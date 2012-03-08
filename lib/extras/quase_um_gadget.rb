class QuaseUmGadget
  def initialize(evento_id,tipo)
    @evento_id = evento_id
    @tipo = tipo
  end
  
  def associa(user)    
    evento = Evento.find(@evento_id)
    if user.tem_gadget? evento,@tipo
      gadget = user.gadget_para evento,@tipo
    else
      gadget = Gadget.create :tipo => @tipo, :evento_id => evento.id, :user_id => user.id
    end
    gadget
  end
end
