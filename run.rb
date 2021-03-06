require_relative 'data_build'
require_relative 'db_structure'
require_relative 'global'

def main
  conn = PG.connect(dbname: 'rpg')
  characters = ''

  loop do
    current_count = count_characters(conn)
    filter_sort_search(conn, current_count, characters)
  end
end

main if __FILE__ == $PROGRAM_NAME
