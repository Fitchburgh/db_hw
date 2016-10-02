require 'pg'

def disable_notices(conn)
  conn.exec('SET client_min_messages to WARNING;')
end

def create_char_table(conn)
  # serial auto incrementing, primary key set to id
  conn.exec(
    'CREATE TABLE IF NOT EXISTS characters (' \
    'id SERIAL PRIMARY KEY,' \
    ' name VARCHAR(30),' \
    ' class VARCHAR(25),' \
    ' armor_value NUMERIC(4),' \
    ' weapon VARCHAR)'
  )
end

def create_character(conn, name, character_class, armor_value, weapon)
  # WHERE is a filter statement
  sql = 'INSERT INTO characters (name, class, armor_value, weapon)' \
    "SELECT '#{name}', '#{character_class}', '#{armor_value}' ," \
    "'#{weapon}'" \
    ' WHERE ' \
    'NOT EXISTS(' \
      'SELECT id FROM characters' \
      " WHERE name = '#{name}' AND class = '#{character_class}'" \
      " AND armor_value = '#{armor_value}' AND weapon = '#{weapon}'" \
    ');'
  conn.exec(sql)
end

def count_characters(conn)
  result = conn.exec('SELECT count(*) FROM characters')
  result.getvalue(0, 0).to_i
end
