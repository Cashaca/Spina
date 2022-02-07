FactoryBot.define do
  factory :account, class: "Spina::Account" do
    name { 'My Website' }
    email { 'bram@spinacms.com' }
    preferences { { theme: 'demo' } }
  end
  factory :account2, class: "Spina::Account" do
    name { 'My second website' }
    domain_name_regex {'dummy'}
    email { 'bram@spinacms.com' }
    preferences { { theme: 'demo2' } }
  end
end
