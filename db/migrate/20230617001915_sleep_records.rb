class SleepRecords < ActiveRecord::Migration[7.0]
  def change
  	create_table :sleep_records, comment: 'Table for storing sleep records' do |t|
	  	t.references :user, null: false, foreign_key: true, comment: 'User reference for the sleep record'
	    t.datetime :sleep_start, comment: 'Start time of sleep'
	    t.datetime :sleep_end, comment: 'End time of sleep'
	    t.integer  :sleep_duration, comment: 'Duration of sleep in minutes'
	    t.timestamps
	  end
  end
end