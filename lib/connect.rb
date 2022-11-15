# frozen_string_literal: true

# Connect to MySql
class Connect
  require 'mysql2'

  def init_connect; end

  def save_to_db(query)
    # Initialize connection variables.
    host     = String('localhost')
    database = String('posts')
    username = String('root')
    password = String('Bhbyf405201#')

    # Initialize connection object.
    client = Mysql2::Client.new(host: host, username: username, database: database, password: password)
    puts 'Successfully created connection to database'

    statement = client.prepare(query[:prepared_query])
    statement.execute(*query[:values])

    last_insert_id = client.last_id

    # Error handling
  rescue StandardError => e
    puts e.message
    # Cleanup
  ensure
    client&.close
    puts 'Connection closed', ''
    last_insert_id
  end

  def read_from_db(limit, id, type)
    # Initialize connection variables.
    host     = String('localhost')
    database = String('posts')
    username = String('root')
    password = String('Bhbyf405201#')

    # Initialize connection object.
    client = Mysql2::Client.new(host: host, username: username, database: database, password: password)
    puts 'Successfully created connection to database'

    if !id.nil?
      # 1 post
      statement = client.prepare('SELECT * FROM posts WHERE post_id = ?')
      result_db = statement.execute(id)

      result = []
      result_db.each do |row|
        result << row
      end
      result = result.first # 1 and only 1

      # filling up
      if result.nil?
        puts "Post #{id} is not found"
        result
      else
        choice = result['post_type']

        post   = Creator.generate_read(choice)
        post.load_data(result)
        post
      end

    else
      # table
      params = {}

      params['post_type'] = type   unless type.nil?
      params['limit']     = limit  unless limit.nil?
      puts params

      query  = 'SELECT * FROM posts '
      query += 'WHERE post_type = ? ' unless type.nil?
      query += 'ORDER by post_id DESC '
      query += 'LIMIT ? ;' unless limit.nil?

      values = params.values

      puts prepared = { prepared_query: query, values: values }

      statement = client.prepare(prepared[:prepared_query])
      result    = statement.execute(*prepared[:values])

    end
  rescue StandardError => e
    puts e.message
  ensure
    client&.close
    puts 'Connection closed', ''
    result
  end
end
