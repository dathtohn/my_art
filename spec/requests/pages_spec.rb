require 'spec_helper'

describe "Pages" do

  describe "Home" do

    it "should have the content 'My Art'" do
      visit '/'
      page.should have_content('My Art')
    end
  end
end