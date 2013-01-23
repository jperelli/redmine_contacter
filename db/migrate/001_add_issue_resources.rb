class AddIssueResources < ActiveRecord::Migration
  def self.up
    create_table :issue_resources, :force => true do |t|
      t.integer "issue_id", :default => 0, :null => false
      t.integer "dependencia_id", :default => 0, :null => false
    end
    create_table :dependencias, :force => true do |t|
      t.integer "oracle_id", :default => :null
      t.string "nombre", :limit => 200, :null => false
      t.string "telefonos", :limit => 200
      t.string "direccion", :limit => 200
      t.string "fax", :limit => 200
      t.string "email", :limit => 200
      t.string "cod4", :limit => 10
      t.string "cod8", :limit => 10
    end
  end

  def self.down
    drop_table :issue_resources
    drop_table :dependencias
  end
end
