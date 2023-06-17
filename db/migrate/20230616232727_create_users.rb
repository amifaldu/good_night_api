class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, comment: 'Table for storing users information' do |t|
      t.string :name, limit: 255, comment: 'The name of the user'
      t.timestamps
    end
  end
end