class AddContextTaggerToTaggings < ActiveRecord::Migration
  def change
    add_reference :taggings, :tagger, index: true, :polymorphic => true
    add_column :taggings, :context, :string
    ActsAsTaggableOn::Tagging.all.each do |tagging|
      tagging.update_attributes! :context => "tags"
    end
  end
end
