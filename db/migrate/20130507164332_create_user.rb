class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :google_id
      t.string :google_token
      t.string :name
      t.string :photo_url

    end
  end
end
