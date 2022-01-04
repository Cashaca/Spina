class AddDomainNameRegexToSpinaAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :spina_accounts, :domain_name_regex, :string
  end
end
