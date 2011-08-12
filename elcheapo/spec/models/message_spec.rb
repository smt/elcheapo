require 'spec_helper'

describe Message do

  before(:each) do
    @time_now = Time.parse("Apr 17 1980")
    Time.stub!(:now).and_return(@time_now)

    @attr = {
      :content => "This is my test content. It is awesome.",
      :exires_at => Time.now.utc + 3600*24
    }
  end

  it "should create a new instance given a valid attribute" do
    Message.create!(@attr)
  end

  it "should require content" do
    no_content_message = Message.new(@attr.merge(:content => ""))
    no_content_message.should_not be_valid
  end

  it "should require expiration to be in the future" do
    past_expiring_message = Message.new(@attr.merge(:expires_at => Time.now.utc - 3600))
    past_expiring_message.should_not be_valid
  end

end
