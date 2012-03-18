module GadgetsHelper
  def eu_vou evento, nome = "Eu vou!", callback = "Confirmado!", st = '', tipo = 'eu_vou'

    content = "<div class='gadget_vou'>"

    if user_signed_in?
      if current_user.tem_gadget? evento,tipo
        content << link_to( callback, root_path, :class => 'ajax_vou_confirmado ' + st)
      else
        content << link_to( nome, gadgets_path(:evento => evento.id, :tipo => Gadget.tipos[tipo.downcase.to_sym][:nome]), :class => 'ajax_vou ' + st, :id => "ajax_vou_#{evento.id}", :remote => true     )   
      end  
    else
      content << link_to( nome, gadgets_path(:evento => evento.id, :tipo => Gadget.tipos[tipo.downcase.to_sym][:nome]), :class => 'ajax_vou ' + st, :id => "ajax_vou_#{evento.id}"    )   
    end

    content << "</div>"
    content.html_safe
  end  

  def user_name gadget
    User.find(gadget.user_id).nickname
  end

  def extension gadget
    image = User.find(gadget.user_id).image
    image_extension image
  end

  def image_extension image
    image.match(/(\w{3,4})$/).to_s    
  end
end
