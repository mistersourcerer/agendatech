require 'spec_helper'

describe Plugins do
  it "deveria retornar ImageTwitter para dev e test" do
      obj = Plugins.new_image_twitter
      obj.class.should eq ImageTwitter
  end
end
