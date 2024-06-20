class AddRememberDigestToUsers < ActiveRecord::Migration[7.0]
  # リスト 9.1:記憶ダイジェスト用に生成したマイグレーション
  def change
    add_column :users, :remember_digest, :string
  end
end
