FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :collection do
    date "Jan 1 2013"
    title "Example Title"
    link "http://wallfive.com/wp-content/uploads/2013/04/black-and-white-girl-640x480.jpg"
    user
  end
end