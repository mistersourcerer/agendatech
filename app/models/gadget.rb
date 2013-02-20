class Gadget < ActiveRecord::Base
  belongs_to :evento
  belongs_to :user

  attr_accessible :tipo, :evento_id, :user_id

  #aqui tem que trocar para o usuario com twitter.
  def self.tipos
    {:eu_vou => {:nome => 'EU_VOU',:label => 'Eu vou!',:label_confirmacao => 'Confirmado!'},
     :promocao => {:nome => 'PROMOCAO',:label => 'Concorrer!',:label_confirmacao => 'Confirmado!'}
    }
  end

  def self.busca_por_tipo tipo
    Gadget.tipos[tipo.downcase.to_sym]
  end
end
