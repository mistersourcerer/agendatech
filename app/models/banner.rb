class Banner < ActiveRecord::Base
  belongs_to :evento
  
  scope :aprovado, where("liberado = ?",true)    
  scope :por_ordem, order("ordem asc")
  
  module WithQueries
    def liberados
      Banner.aprovado.por_ordem.includes(:evento).all
    end
  end 
  
  extend WithQueries
end
