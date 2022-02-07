FactoryBot.define do
  factory :resource, class: "Spina::Resource" do

    factory :breweries do
      name { 'breweries' }
      label { 'Breweries' }
      association :account, factory: :account
    end

  end
end
