class AddAccountRelationToPagesResourcesNavigations < ActiveRecord::Migration[6.1]
  def change
    add_reference :spina_pages, :account, index: true
    add_reference :spina_resources, :account, index: true
    add_reference :spina_navigations, :account, index: true
  end
end
