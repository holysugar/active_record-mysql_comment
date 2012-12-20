# ActiveRecord::MysqlComment

to use MySQL comment column

this library is experimental :(

## Installation

Add this line to your application's Gemfile:

    gem 'active_record-mysql_comment'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record-mysql_comment

## Reading Comment

For example:

```
mysql> SHOW FULL FIELDS FROM test_models;
+-------------------+------------+-----------------+------+-----+---------+-------+---------------------------------+----------------+
| Field             | Type       | Collation       | Null | Key | Default | Extra | Privileges                      | Comment        |
+-------------------+------------+-----------------+------+-----+---------+-------+---------------------------------+----------------+
| comment_string    | varchar(1) | utf8_general_ci | YES  |     | NULL    |       | select,insert,update,references | column comment |
| ja_comment_string | varchar(1) | utf8_general_ci | YES  |     | NULL    |       | select,insert,update,references | コメント       |
+-------------------+------------+-----------------+------+-----+---------+-------+---------------------------------+----------------+
```

```ruby
class TestModel < ActiveRecord::Base
end
```

How to read comment

```ruby
column = TestModel.columns.find{|c| c.name == 'comment_string' }
column.comment #=> 'column comment'
```

## Migration

In create_table:

```ruby
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
```

In change_table:
```
class ChangeExamples < ActiveRecord::Migration
  def up
    change_table :examples do |t|
      t.change :commented,           :string, :comment => 'changed comment'
      t.change :uncommented,         :string, :comment => 'appended'
      t.change :commented_to_delete, :string

      t.string :new_commented, :comment => 'new comment'
      t.string :new_no_comment
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
