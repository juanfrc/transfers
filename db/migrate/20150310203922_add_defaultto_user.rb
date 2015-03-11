class AddDefaulttoUser < ActiveRecord::Migration
  def change
  	change_column :users, :balance, :string, :default => 50000
  end
end
