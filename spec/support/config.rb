require 'yaml'
require 'fileutils'
require 'pathname'

module ARTest
  class << self
    def config
      @config ||= read_config
    end

    private

    def config_file
      Pathname.new(ENV['ARCONFIG'] || TEST_ROOT + '/config.yml')
    end

    def read_config
      unless config_file.exist?
        FileUtils.cp TEST_ROOT + '/config.example.yml', config_file
      end

      expand_config(YAML.parse(config_file.read).transform)
    end

    def expand_config(config)
      config['connections'].each do |adapter, connection|
        dbs = [['arunit', 'activerecord_unittest']]
        dbs.each do |name, dbname|
          unless connection[name].is_a?(Hash)
            connection[name] = { 'database' => connection[name] }
          end

          connection[name]['database'] ||= dbname
          connection[name]['adapter']  ||= adapter
        end
      end

      config
    end
  end
end
