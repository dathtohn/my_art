require 'spec_helper'

describe Collection do

  let(:user) { FactoryGirl.create(:user) }
  before { @collection = user.collections.build(date: "Jan 1 2013", title: "Example", link: "http://2.bp.blogspot.com/-nUkEgvQsRnc/UDzOdh82pUI/AAAAAAAAANs/uVIxdSLs59Y/s1600/Kate_Bosworth-Pic-2012-01.jpg") }

  subject { @collection }

  it { should respond_to(:date) }
  it { should respond_to(:title) }
  it { should respond_to(:link) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when link format is valid" do
    it "should be valid" do
      urls = %w[http://wallfive.com/wp-content/uploads/2013/04/black-and-white-girl-640x480.jpg http://www.esquire.com/cm/esquire/images/SZ/esq-something-cool-we-saw-online-girl-habit-de.jpg]
      urls.each do |valid_url|
        @collection.link = valid_url
        @collection.should be_valid
      end      
    end
  end

  describe "when link format is invalid" do
    it "should be invalid" do
      urls = %w[http://wallfive.com/wp-content/uploads/2013/04/black-and-white-girl-640x480]
      urls.each do |valid_url|
        @collection.link = valid_url
        @collection.should_not be_valid
      end      
    end
  end

  describe "when user_id is not present" do
    before { @collection.user_id = nil }
    it { should_not be_valid }
  end

  describe "when the date is blank" do
    before { @collection.date = " " }
    it { should_not be_valid }
  end

  describe "when the title is blank" do
    before { @collection.title = " " }
    it { should_not be_valid }
  end

  describe "when the link is blank" do
    before { @collection.link = " " }
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