class UsersTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(username, email, password)
    insert_user_sql = <<-SQL
      INSERT INTO users (username, email, password)
      VALUES ('#{username}', '#{email}', '#{password}')
      RETURNING id
    SQL

    @database_connection.sql(insert_user_sql).first["id"]
  end

  def find(id)
    find_sql = <<-SQL
      SELECT * FROM users
      WHERE id = #{id}
    SQL

    @database_connection.sql(find_sql).first
  end

  def find_by(username, password)
    find_by_sql = <<-SQL
      SELECT * FROM users
      WHERE username = '#{username}'
      AND password = '#{password}'
    SQL

    @database_connection.sql(find_by_sql).first
  end

  def find_id_by_name(username)
    find_sql = <<-SQL
      SELECT * FROM users
      WHERE username = '#{username}'
    SQL

    @database_connection.sql(find_sql).first
  end

  def delete(id)
    @database_connection.sql("DELETE FROM users where id = #{id}")
  end

  def select_all
    select_sql = "select * from users"
    @database_connection.sql(select_sql)
  end

end