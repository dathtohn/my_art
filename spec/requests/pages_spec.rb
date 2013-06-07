require 'spec_helper'

describe "Pages" do

  subject { page }

  describe "about page" do
    before { visit about_path}

    it { should have_selector('h1',     text: 'About') }
    it { should have_selector('title',  text: full_title('About')) }
  end
  
end