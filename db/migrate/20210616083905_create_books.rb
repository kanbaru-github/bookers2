class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|

      t.string :title
      t.string :body
      t.integer :user_id
      t.float :rate

      t.timestamps
    end
  end
end
