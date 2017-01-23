require 'active_record/connection_adapters/abstract_adapter'

class ActiveRecord::Base
  def self.staticfile_connection(config)
    ActiveRecord::ConnectionAdapters::StaticFileAdapter.new(config)
  end
end

class ActiveRecord::ConnectionAdapters::StaticFileAdapter <
    ActiveRecord::ConnectionAdapters::AbstractAdapter
  class Statement
    attr_reader :entry_point, :content

    def initialize(entry_point, content = "")
      @entry_point, @content = entry_point, content
    end

    def ==(other)
      self.entry_point == other.entry_point
    end
  end

  # Recognized options:
  #
  # [+:schema+] path to the schema file, relative to RAILS_ROOT
  def initialize(config={})
    @db_path = config.fetch(:database) || 'db/'
    @tables = Dir[File.join(@db_path, '*.csv')].map{|f| [File.basename(f), {}]}.to_h
    super(nil, @logger)
  end

  def adapter_name
    "StaticFile"
  end

  def supports_migrations?
    false
  end

  def tables
    @tables.keys.map(&:to_s)
  end

  def columns(table_name, name = nil)
    if @tables.size <= 1
      ActiveRecord::Migration.verbose = false
      Kernel.load(File.join(RAILS_ROOT, @schema_path))
    end
    table = @tables[table_name]
    table.columns.map do |col_def|
      ActiveRecord::ConnectionAdapters::Column.new(col_def.name.to_s,
                                                    col_def.default,
                                                    col_def.type,
                                                    col_def.null)
    end
  end

  def select_all(statement, name=nil, binds = [])
    super(statement, name)
  end

=begin
  def execute(statement, name = nil)
  end

  def select_rows(statement, name = nil)
    raise "hoge"
  end

  def select_one(statement, name=nil)
    super(statement, name)
  end

  def select_value(statement, name=nil)
    super(statement, name)
  end

  def insert(statement, name, primary_key, object_id, sequence_name)
    super(statement, name, primary_key, object_id, sequence_name)
  end

  def update(statement, name=nil)
    super(statement, name)
  end

  def delete(statement, name=nil)
    super(statement, name)
  end
=end
end
