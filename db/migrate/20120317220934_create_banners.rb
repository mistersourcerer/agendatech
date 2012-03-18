class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.integer :evento_id
      t.boolean :liberado,:default => false
      t.integer :ordem
      t.string  :tipo_gadget_associado,:default => Gadget.tipos[:eu_vou]
      t.string  :nome_imagem
      t.string  :descricao
      t.string  :titulo
      t.timestamps
    end
  end
end
  