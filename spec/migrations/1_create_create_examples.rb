require 'helpers/establish'

class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :name, :null => false, :comment => 'example name'
      t.string :uncommented, :default => ''
      t.column :number_column, :integer, :comment => 'example number'
      t.timestamps

      #puts t.to_sql
    end
  end
end
