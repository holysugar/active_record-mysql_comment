# coding: utf-8

require 'helpers/establish'

def load_schema
  puts 'load_schema'
  ActiveRecord::Base.connection.execute <<-SQL
DROP TABLE IF EXISTS test_models
  SQL
  ActiveRecord::Base.connection.execute <<-SQL
CREATE TABLE test_models (
  comment_string    VARCHAR(1) COMMENT 'column comment',
  ja_comment_string VARCHAR(1) COMMENT 'コメント'
) CHARACTER SET utf8 COMMENT 'table comment'
  SQL
end

load_schema

class TestModel < ActiveRecord::Base
end

