class Connect

  def save_to_db(query)
    begin
    # Initialize connection variables.
    host = String('localhost')
    database = String('posts')
    username = String('root')
    password = String('Bhbyf405201#')
  
    # Initialize connection object.
    client = Mysql2::Client.new(:host => host, :username => username, :database => database, :password => password)
    puts 'Successfully created connection to database.'

    statement = client.prepare(query[:prepared_query])
    result = statement.execute(*query[:values])

    insert_row_id = client.query ("SELECT LAST_INSERT_ID();")

    # Error handling
    rescue Exception => e
      puts e.message
    # Cleanup
    ensure
      client.close if client
      puts 'Done.'
      return insert_row_id
    end
  end

end