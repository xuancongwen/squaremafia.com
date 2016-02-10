class CreateMailingLists < ActiveRecord::Migration
  def change
    create_table :mailing_lists do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    create_join_table(:mailing_lists, :users, table_name: :mailing_list_subscriptions) do |t|
      t.index :user_id
      t.index :mailing_list_id

      t.index [:mailing_list_id, :user_id], unique: true, name: :all_unique
      t.timestamps null: false
    end
  end
end
