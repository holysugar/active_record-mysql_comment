require "active_record"
require "active_record/connection_adapters/abstract_mysql_adapter"
require "active_record-mysql_comment/schema_dumper"
require "active_record-mysql_comment/version"

module ActiveRecord
  module ConnectionAdapters

    class AbstractMysqlAdapter
      class Column
        # not using attr_reader to avoid change initialize interface,
        # which is different between version 3.x and 4.x.
        attr_accessor :comment
      end

      class TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
        def new_column_definition(base, name, type)
          definition = ColumnDefinition.new base, name, type
          @columns << definition
          @columns_hash[name] = definition
          definition
        end

        def column(name, type, options = {})
          super
          self[name].comment = options[:comment]
        end
      end

      class ColumnDefinition < ActiveRecord::ConnectionAdapters::ColumnDefinition
        attr_accessor :comment

        def to_sql
          sql = super
          base.add_column_comment_option!(sql, comment) unless comment.nil?
          sql
        end
      end

      # overwrite
      def columns(table_name, name = nil) #:nodoc:
        sql = "SHOW FULL FIELDS FROM #{quote_table_name(table_name)}"
        execute_and_free(sql, 'SCHEMA') do |result|
          each_hash(result).map do |field|
            c = new_column(field[:Field], field[:Default], field[:Type], field[:Null] == "YES", field[:Collation])
            c.comment = field[:Comment]
            c
          end
        end
      end

      def add_column_comment_option!(sql, comment) #:nodoc:
        sql << " COMMENT #{quote(comment)}"
      end

      def add_column_options!(sql, options) #:nodoc:
        super
        add_column_comment_option!(sql, options[:comment]) if options[:comment]
      end

      def table_definition #:nodoc:
        TableDefinition.new(self)
      end
    end
  end
end
