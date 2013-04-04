class Grupo < ActiveRecord::Base
  has_many :eventos

  acts_as_taggable
  Plugins.paper_clip self  

  validates_presence_of :nome
  validates_presence_of :site
  validates_uniqueness_of :nome

  attr_accessible :logo, :nome, :tag_list, :site

  scope :nao_aprovados, -> { where aprovado: false }
  scope :aprovados, -> { where aprovado: true }
  scope :por_nome, -> { order("nome ASC") }

  def aprovar!
    update_attribute(:aprovado, true)
  end

  def reprovar!
    update_attribute(:aprovado, false)
  end

  def atualiza_tags(tags_string)
    ActsAsTaggableOn::Tagging.where(taggable_type: self.class, taggable_id: id).each {|t| t.destroy}
    tag_list = ActsAsTaggableOn::TagList.from tags_string
    tags = ActsAsTaggableOn::Tag.find_or_create_all_with_like_by_name tag_list
    tags.each do |tag|
      ActsAsTaggableOn::Tagging.create! tag_id: tag.id, context: "tags", taggable: self
    end
  end
end
