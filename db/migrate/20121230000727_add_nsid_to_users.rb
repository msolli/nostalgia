class AddNsidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nsid, :string
  end
end
