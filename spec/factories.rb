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
  	content 							'foobar'
 		notecard.association 	:user
 	end
 end