# frozen_string_literal: true

# Connect to MySql
class Connect
  def init_connect
    # Initialize connection variables.

    connect = {}
    connect[:host] = String('localhost')
    connect[:database] = String('posts')
    connect[:username] = String('root')
    connect[:password] = String('Bhbyf405201#')

    connect
  end

  def prepare_sql_write(entry)
    db_hash = entry.to_db_hash

    substituted_columns = db_hash.keys.map { '?' }.join(', ')
    prepared_query      = "INSERT INTO #{init_connect[:database]} VALUES (#{substituted_columns});"
    values              = db_hash.values

    { prepared_query: prepared_query, values: values }
  end

  def prepare_sql_read(limit, id, type)
    params = {}
    params['post_id']   = id    unless id.nil?
    params['post_type'] = type  unless type.nil?
    params['limit']     = limit unless limit.nil?

    query  = 'SELECT * FROM posts '
    query += 'WHERE post_id = ? ' unless id.nil?
    query += 'WHERE post_type = ? ' unless type.nil?
    query += 'ORDER by post_id DESC '
    query += 'LIMIT ? ;' unless limit.nil?

    { prepared_query: query, values: params.values }
  end

  def execute_sql(query)
    connect = init_connect
    client = Mysql2::Client.new(host: connect[:host], username: connect[:username], database: connect[:database],
                                password: connect[:password])
    puts '', 'Successfully created connection to database'

    statement = client.prepare(query[:prepared_query])
    result    = statement.execute(*query[:values])

    last_insert_id = client.last_id
    { result: result, last_insert_id: last_insert_id }
  rescue StandardError => e
    puts e.message
  ensure
    client&.close
    puts 'Connection closed', ''
  end
end
