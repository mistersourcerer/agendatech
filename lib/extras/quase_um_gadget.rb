class QuaseUmGadget
  def initialize(evento_id,tipo)
    @evento_id = evento_id
    @tipo = tipo
  end
  
  def associa(user)    
    if user.tem_gadget? Evento.find(@evento_id),@tipo
      gadget = user.gadget_para @evento,@tipo
    else
      gadget = Gadget.create :tipo => @tipo, :evento_id => @evento_id, :user_id => user.id
    end
    gadget
  end
end
