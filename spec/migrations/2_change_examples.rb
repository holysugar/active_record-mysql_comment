class ChangeExamplesBefore < ActiveRecord::Migration
  def change
    create_table :change_examples do |t|
      t.string :commented,           :comment => 'example'
      t.string :uncommented
      t.string :commented_to_delete, :comment => 'example'
    end
  end
end

class ChangeExamples < ActiveRecord::Migration
  def up
    change_table :change_examples do |t|
      t.change :commented,           :string, :comment => 'changed comment'
      t.change :uncommented,         :string, :comment => 'appended'
      t.change :commented_to_delete, :string

      t.string :new_commented, :comment => 'new comment'
      t.string :new_no_comment
    end
  end
end

