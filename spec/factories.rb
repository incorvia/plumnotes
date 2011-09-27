FactoryGirl.define do
  factory :user do
    email                  'user@test.com'
    password               'foobar'
    password_confirmation  'foobar'
  end
end