require 'sequel'
require 'securerandom'
require 'json'

require 'yaml'

def env
    ENV['RACK_ENV'] || 'development'
end

def root
    File.expand_path(File.dirname(__FILE__))
end

def config
    config = YAML.load_file(File.join(root,'config','database.yml'))[env] rescue nil
end

dsn = ENV['DATABASE_URL'] || config || 'postgres://localhost/descartes'

DB = Sequel.connect(dsn)
DB.extension :pagination

$LOAD_PATH.unshift File.dirname(__FILE__)
require 'graphs'
require 'tags'
require 'dashboards'
require 'graph_dashboard_relations'
require 'gists'
require 'comments'
require 'metrics'
require 'users'

Sequel.extension :core_extensions

Sequel::Model.plugin :json_serializer
Graph.plugin :json_serializer
Dashboard.plugin :json_serializer
Tag.plugin :json_serializer
Gist.plugin :json_serializer
Comment.plugin :json_serializer
User.plugin :json_serializer
