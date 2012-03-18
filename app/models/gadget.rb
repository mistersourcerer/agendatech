class Gadget < ActiveRecord::Base
  belongs_to :evento
  belongs_to :user
  #aqui tem que trocar para o usuario com twitter.
  def self.tipos
    {:eu_vou => {:nome => 'EU_VOU',:label => 'Eu vou!',:label_confirmacao => 'Confirmado!'},
     :promocao => {:nome => 'PROMOCAO',:label => 'Concorrer!',:label_confirmacao => 'Confirmado!'}
    }
  end    
end
