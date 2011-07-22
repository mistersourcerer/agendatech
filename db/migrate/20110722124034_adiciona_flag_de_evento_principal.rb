class AdicionaFlagDeEventoPrincipal < ActiveRecord::Migration
  def self.up
    add_column :eventos, :destaque, :boolean,:default => false
  end

  def self.down
    remove_column :eventos,:destaque
  end
end
