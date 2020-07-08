class CreateReads < ActiveRecord::Migration[6.0]
  def change
    create_table :reads do |t|
      t.references :user, foreign_key: true, index: true
      t.string :tweet_id

      t.timestamps
    end
    add_index :reads, :tweet_id
  end
end
