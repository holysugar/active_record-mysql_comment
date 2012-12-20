# ActiveRecord::MysqlComment

to use MySQL comment column

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

TODO (Not yet implemented)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
