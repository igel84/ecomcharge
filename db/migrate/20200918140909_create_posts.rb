class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.bigint  :user_id, null: false
      t.string  :title, limit: 1000, null: false
      t.text    :body, null: false
      t.string  :ip, null: false
      t.float   :average_mark, null: false, default: 1
      t.timestamps null: false

      t.index ["user_id"], name: "index_posts_on_user_id"
    end
  end
end
