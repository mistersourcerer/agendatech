require 'spec_helper'

describe GadgetsHelper do

  context "Gadget com user_id 1" do
    let(:gadget) { Gadget.new {|g| g.user_id = 1} }

    it "deveria devolver extencao com 3 caracteres" do
      user = User.new :image => "anderson_leite.jpg"
      User.should_receive(:find).with(1).and_return(user)
      expect(helper.extension(gadget)).to be == "jpg"
    end

    it "deveria devolver extencao com 4 caracteres" do
      user = User.new :image => "anderson_leite.jpeg"
      User.should_receive(:find).with(1).and_return(user)
      expect(helper.extension(gadget)).to be == "jpeg"
    end

  end# context

end


