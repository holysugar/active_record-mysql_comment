require 'logger'

module ARTest
  def self.connection_name
    ENV['ARCONN'] || config['default_connection']
  end

  def self.connection_config
    config['connections'][connection_name]
  end

  def self.connect
    puts "Using #{connection_name}"
    # rails4 では Base -> Model
    klass = defined?(ActiveRecord::Model) ? ActiveRecord::Model : ActiveRecord::Base
    klass.logger = Logger.new("debug.log")
    klass.configurations = connection_config
    klass.establish_connection 'arunit'
  end
end
