class ReorganizeNavigationIndexes < ActiveRecord::Migration[6.0]
  def change
    # remove uniqueness constraint
    remove_index :spina_navigations, :name
    add_index :spina_navigations, :name, using: :btree
    # add uniqueness to combination of account and name
    add_index :spina_navigations, [:account_id, :name], unique: true
  end
end
