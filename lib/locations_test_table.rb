class LocationsTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(name, latitude, longitude, phone, address)
    insert_user_sql = <<-SQL
      INSERT INTO locations_test (name, latitude, longitude, phone, address)
      VALUES ('#{name}', #{latitude}, #{longitude}, '#{phone}', '#{address}')
      RETURNING id
    SQL

    @database_connection.sql(insert_user_sql).first["id"]
  end

end
