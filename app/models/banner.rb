class Banner < ActiveRecord::Base
  belongs_to :evento

  scope :aprovado, -> { where("liberado = ?",true) }
  scope :por_ordem, -> { order("ordem asc") }

  def gadget_info
    Gadget.tipos[self.tipo_gadget_associado.downcase.to_sym]
  end

  def self.liberados
    Banner.aprovado.por_ordem.includes(:evento).all
  end
end
