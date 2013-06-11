require 'spec_helper'

describe Collection do

  let(:user) { FactoryGirl.create(:user) }
  before { @collection = user.collections.build(date: "Jan 1 2013", title: "Example", link: "http://wallfive.com/wp-content/uploads/2013/04/black-and-white-girl-640x480.jpg") }

  subject { @collection }

  it { should respond_to(:date) }
  it { should respond_to(:title) }
  it { should respond_to(:link) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @collection.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Collection.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end