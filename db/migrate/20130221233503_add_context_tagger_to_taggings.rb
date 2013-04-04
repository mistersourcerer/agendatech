class AddContextTaggerToTaggings < ActiveRecord::Migration
  def change
    add_reference :taggings, :tagger, index: true, :polymorphic => true
    add_column :taggings, :context, :string
    ActsAsTaggableOn::Tagging.update_all(context: "tags")
  end
end
