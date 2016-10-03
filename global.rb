# global functions
def find_characters(conn)
  conn.exec('SELECT * FROM characters ORDER BY class ASC')
end

def list_db(characters)
  characters.each do |character|
    puts "ID: #{character['id']}  | " \
    "Name: #{character['name']} | " \
    "Class: #{character['class']} | " \
    "Armor value: #{character['armor_value']} | " \
    "Weapon: #{character['weapon']}"
  end
  puts "\n\n"
end

def sort_by_input(conn, column_to_sortby, order)
  result = conn.exec("SELECT * FROM characters ORDER BY #{column_to_sortby}" \
  " #{order}")
  puts "\n\n\n\nSorted by #{column_to_sortby}:"
  result.each do |character|
    puts "#{character['name']} | #{character["#{column_to_sortby}"]} "
  end
end

def name_sort(conn, _name, order)
  result = conn.exec("SELECT * FROM characters ORDER BY name #{order}")
  puts 'Character List:'
  result.each do |character|
    puts "#{character['name']}:" \
    " #{character['class']} | " \
    "AR: #{character['armor_value']} | " \
    "Wielding: #{character['weapon']}"
  end
end

def set_weapon(conn, weapon, char)
  conn.exec("UPDATE characters SET weapon= '#{weapon}' WHERE name= '#{char}'")
end

def update_weapon(conn)
  print 'Which character would you like to update: '
  char_to_edit = gets.chomp.capitalize
  print 'Which weapon are you now using: '
  weapon_to_use = gets.chomp
  set_weapon(conn, weapon_to_use, char_to_edit)
end

def new_character(conn, name, character_class, armor_value, weapon)
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

def user_create_tool(conn)
  print "Welcome to the character generator!\nPlease enter a name: "
  new_name = gets.chomp.capitalize
  print 'What class: '
  new_class = gets.chomp
  print 'Whats your armor value: '
  new_av = gets.chomp.to_i
  print 'What weapon are you using: '
  new_weapon = gets.chomp
  new_character(conn, new_name, new_class, new_av, new_weapon)
end

def sort_options(conn)
  print 'Please select which column to sort by' \
  "\n1 ≈ name\n2 ≈ character_class\n" \
  "3 ≈ armor_value\n4 ≈ weapon\noption: "
  number_sort = gets.chomp.to_i
  print "please type ASC or DESC for order\noption: "
  asc_desc = gets.chomp.upcase
  asc_desc = 'ASC' if asc_desc != 'ASC' || 'DESC'
  if number_sort == 1
    name_sort(conn, 'name', asc_desc)
  elsif number_sort == 2
    column_to_sortby = 'class'
    sort_by_input(conn, column_to_sortby, asc_desc)
  elsif number_sort == 3
    column_to_sortby = 'armor_value'
    sort_by_input(conn, column_to_sortby, asc_desc)
  elsif number_sort == 4
    column_to_sortby = 'weapon'
    sort_by_input(conn, column_to_sortby, asc_desc)
  end
end

def filter_sort_search(conn, current_count, characters)
  print "There are currently #{current_count} characters in the database." \
  "\nSelect 1-4 or any other to quit:\n1 ≈ List\n2 ≈ Sort\n3 ≈ Update Weapon\n" \
  "4 ≈ Character Create\noption: "
  option = gets.chomp.to_i
  if option == 1
    characters = find_characters(conn)
    list_db(characters)
  elsif option == 2
    sort_options(conn)
  elsif option == 3
    update_weapon(conn)
  elsif option == 4
    user_create_tool(conn)
  elsif option != (1..4)
    puts 'Thanks for checking out the game!'
    exit
  end
end

# UPDATE Customers

# def sort_by_armor(conn)
#   result = conn.exec('SELECT * FROM characters ORDER BY armor_value DESC')
#   # can add diff columns instead of the *
#   # Conn is being passed in .... is that a class!!?!?!
#   puts 'Armor Rankings:'
#   result.each do |character|
#     puts "Name: #{character['name']} ≈ #{character['armor_value']}"
#   end
# end

# def user_inputs
#   print 'Please select which column to sort by' \
#   "\n1 ≈ name\n2 ≈ character_class\n" \
#   "3 ≈ armor_value\n4 ≈ weapon\noption: "
#   number_sort = gets.chomp.to_i
#   print "please type ASC or DESC for order\noption: "
#   asc_desc = gets.chomp.upcase
#   asc_desc = 'ASC' if asc_desc != 'ASC' || 'DESC'
# end
