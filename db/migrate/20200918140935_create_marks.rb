class CreateMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :marks do |t|
      t.bigint  :post_id, null: false
      t.integer :value, null: false
      t.timestamps null: false
      t.index [:post_id], name: "index_marks_on_post_id"
    end
  end
end
