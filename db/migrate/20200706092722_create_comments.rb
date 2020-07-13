class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, foreign_key: true, index: true
      t.string :tweet_id

      t.timestamps
    end
    add_index :comments, :tweet_id
  end
end
