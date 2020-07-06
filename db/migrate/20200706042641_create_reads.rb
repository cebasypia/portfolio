class CreateReads < ActiveRecord::Migration[6.0]
  def change
    create_table :reads do |t|
      t.integer :user_id
      t.string :tweet_id

      t.timestamps
    end
  end
end
