require 'pg'

def disable_notices(conn)
  conn.exec('SET client_min_messages to WARNING;')
end

def create_character(conn, name, character_class)
  # WHERE is a filter statement
  sql = 'INSERT INTO characters (name, class)' \
    "SELECT '#{name}', '#{character_class}' " \
    'WHERE' \
    'NOT EXISTS(' \
      'SELECT id FROM characters' \
      " WHERE name = '#{name}' AND class = '#{character_class}'" \
    ');'

  conn.exec(sql)
end

def create_char_table(conn)
  # serial auto incrementing, primary key set to id
  conn.exec(
    'CREATE TABLE IF NOT EXISTS characters (' \
    'id SERIAL PRIMARY KEY,' \
    'name VARCHAR,' \
    'class VARCHAR)'
  )
end

def count_characters(conn)
  result = conn.exec('SELECT count(*) FROM characters')
  result.getvalue(0, 0).to_i
end
