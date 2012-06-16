Mongoid.skip_version_check = true

# Connection.new takes host, port
port = Mongo::Connection::DEFAULT_PORT

case Padrino.env
  when :development then
    connection = Mongo::Connection.new("localhost", port, {:pool_timeout => 60, :pool_size => 5, :timeout => 10})
    Mongoid.database = connection.db("tales_you_win")
  when :production then
    uri  = URI.parse(ENV['MONGO_PRODUCTION_URI'] || ENV['MONGOLAB_URI'])
    connection = Mongo::Connection.from_uri(ENV['MONGO_PRODUCTION_URI'] || ENV['MONGOLAB_URI'])
    Mongoid.database = connection.db(uri.path.gsub(/^\//, ''))
end

MONGO_CONNECTION = connection