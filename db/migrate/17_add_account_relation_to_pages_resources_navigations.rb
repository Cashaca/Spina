class AddAccountRelationToPagesResourcesNavigations < ActiveRecord::Migration[6.1]
  def change
    add_reference :spina_pages, :account, index: true
    add_reference :spina_resources, :account, index: true
    add_reference :spina_navigations, :account, index: true
    account = Spina::Account.first
    if account
      Spina::Page.where(account_id:nil).update_all(account_id:account.id)
      Spina::Resource.where(account_id:nil).update_all(account_id:account.id)
      Spina::Navigation.where(account_id:nil).update_all(account_id:account.id)
    end
  end
end
