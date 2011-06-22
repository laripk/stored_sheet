class CreateAdhocTables < ActiveRecord::Migration
  def self.up
    create_table :adhoc_tables do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :adhoc_tables
  end
end
