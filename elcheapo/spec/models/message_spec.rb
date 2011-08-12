require 'spec_helper'

describe Message do

  before(:each) do
    @attr = {
      :content => "This is my test content. It is awesome."
    }
  end

  it "should create a new instance given a valid attribute" do
    Message.create!(@attr)
  end

  it "should require content" do
    no_content_message = Message.new(@attr.merge(:content => ""))
    no_content_message.should_not be_valid
  end

end
