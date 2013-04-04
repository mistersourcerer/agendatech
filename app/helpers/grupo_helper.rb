module GrupoHelper

  def tag_list(grupo)
    grupo.tag_counts_on(:tags).map{ |tag| tag.name }.join ","
  end
end
