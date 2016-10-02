
require_relative 'db_structure'
# LIKE, ORDER BY, ALTER TABLE, UPDATE, SELECT - COUNT, SUM/AVG???, ORDER BY,
# WHERE id = xxx, DELETE WHERE = xxx, INSERT INTO TABLE IF NOT EXISTS
# WHERE Is a filter.
# UPDATE - update WHERE ID = xxx -filter and update. SET class = 'Grey Wizard'
# WHERE id = 1

def main
  conn = PG.connect(dbname: 'rpg')
  disable_notices(conn)
  create_char_table(conn)

  create_character(conn, 'Torg', 'warrior', 60, 'Reaper')
  create_character(conn, 'Stazi', 'druid', 30, 'Stave of Demise')
  create_character(conn, 'Tacopies', 'shaman', 45, 'Dual Axes')
  create_character(conn, 'Iman', 'healer', 15, 'Book of Truth')
  create_character(conn, 'Kappy', 'assassin', 30, 'Dagger of Death')


end

main if __FILE__ == $PROGRAM_NAME
