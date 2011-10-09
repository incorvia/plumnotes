FactoryGirl.define do

  factory :user do
    email                  'user@test.com'
    password               'foobar'
    password_confirmation  'foobar'
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :notecard do |notecard|
  	content 							'This is a note. @tag1 More note. @tag2 inc@gmail.com. '
 		notecard.association 	:user
 	end

 end