# リスト 10.55:boolean型のadmin属性をUserに追加するマイグレーション
class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    # add_column :users, :admin, :boolean # デフォルト
    add_column :users, :admin, :boolean, default: false
  end
end
