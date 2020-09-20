class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.timestamps null: false
      t.index ["login"], name: "index_users_on_login"
    end
  end
end
