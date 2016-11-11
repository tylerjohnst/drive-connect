require 'bundler/setup'

Bundler.setup

require 'fileutils'
require 'json'
require 'ostruct'
require 'yaml'
require 'drive_connect' # and any other gems you need
require 'sqlite3'
require 'base64'

$fixture_cache = {}

DriveConnect::Store::Database.path_to_database = 'tmp/test.sqlite3'

RSpec.configure do |config|
  config.after(:each) do
    path = DriveConnect::Store::Database.path_to_database
    FileUtils.rm(path) if File.exists?(path)
  end
end

def build(model_name, attributes = {})
  fixture = load_fixture(model_name)
  klass   = eval "DriveConnect::Models::#{model_name.to_s.capitalize}"
  fixture = fixture[0] if fixture.is_a?(Array)
  klass.new fixture.merge(attributes)
end

def build_collection(model_name)
  fixtures = load_fixture(model_name)
  klass   = eval "DriveConnect::Models::#{model_name.to_s.capitalize}"

  if fixtures.is_a? Array
    fixtures.map { |fixture| klass.new(fixture) }
  else
    [ klass.new(fixtures) ]
  end
end

def load_fixture(model_name)
  $fixture_cache[model_name] ||= YAML.load(File.read("#{File.dirname(__FILE__)}/fixtures/#{model_name}.yml"))
end

class FakeHTTPAdapter
  def self.post!(opts, &block)
    block.call({})
  end

  def self.put!(opts, &block)
    block.call({})
  end

  def self.get!(opts, &block)
    block.call({})
  end
end

class FakeSQLiteAdapter
  def self.execute(*args)
  end
end

class FakeAPIHTTPAdapter
  def self.index!(resource, &block)
  end
end

class FakeAR
  def initialize(attributes = {})
    @attributes = attributes
  end

  def update_attributes(attributes)
    @attributes.merge!(attributes)
  end

  def method_missing(method_name, *args, &block)
    @attributes[method_name.to_s]
  end
end
