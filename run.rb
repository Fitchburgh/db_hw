require_relative 'db_structure'
# LIKE, ORDER BY, ALTER TABLE, UPDATE, SELECT - COUNT, SUM/AVG???, ORDER BY,
# WHERE id = xxx, DELETE WHERE = xxx, INSERT INTO TABLE IF NOT EXISTS
# WHERE Is a filter.
# UPDATE - update WHERE ID = xxx -filter and update. SET class = 'Grey Wizard'
# WHERE id = 1

def main
  conn = PG.connect(dbname: 'players')
  disable_notices(conn)
  create_char_table(conn)
  create_character('Gandalf', 'White Wizard')

  result = conn.exec('SELECT * FROM characters ORDER BY name ASC') # can add diff columns instead of the *
  # Conn is being passed in .... is that a class!!?!?!
  result.each do |character|
    puts "name: #{character['name']}"
  end
end

main if __FILE__ == $PROGRAM_NAME
