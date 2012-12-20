require "active_record"
require "active_record/connection_adapters/abstract_mysql_adapter"
require "active_record-mysql_comment/version"

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      class Column

        # not using attr_reader to avoid change initialize interface,
        # which is different between version 3.x and 4.x.
        attr_accessor :comment
      end

      # overwrite
      def columns(table_name, name = nil)#:nodoc:
        sql = "SHOW FULL FIELDS FROM #{quote_table_name(table_name)}"
        execute_and_free(sql, 'SCHEMA') do |result|
          each_hash(result).map do |field|
            c = new_column(field[:Field], field[:Default], field[:Type], field[:Null] == "YES", field[:Collation])
            c.comment = field[:Comment]
            c
          end
        end

      end

    end

  end
end
