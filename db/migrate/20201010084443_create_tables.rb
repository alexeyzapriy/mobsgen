class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :stoats do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.string :type
      t.text :details
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end

    create_table :invitations do |t|
      t.references :stoat, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
