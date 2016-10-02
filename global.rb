# global functions

def filter_sort_search(conn, current_count)
  puts "There are currently #{current_count} characters in the database."
  puts "1 ≈ List\n2 ≈ Sort\n3 ≈ Filter"
  option = gets.chomp.to_i
  if option == 1
    list_db(conn)
  elsif option == 2
    sort_options(conn)
  elsif option == 3
    filter_options(conn)
  end
end

def sort_by_input(conn, column_to_sortby, order)
  result = conn.exec("SELECT * FROM characters ORDER BY #{column_to_sortby} #{order}")
  puts "Sorted by #{column_to_sortby}:"
  result.each do |character|
    puts "#{character['name']} ≈ #{character["#{column_to_sortby}"]} "
  end
end

def name_sort(conn, _name, order)
  result = conn.exec("SELECT * FROM characters ORDER BY name #{order}")
  puts 'Character list:'
  result.each do |character|
    puts "#{character['name']}:" \
    " #{character['class']} " \
    "AR: #{character['armor_value']} " \
    "Wielding: #{character['weapon']}"
  end
end

def sort_options(conn)
  puts "Please select which column to sort by\n1 ≈ name\n2 ≈ character_class\n" \
  "3 ≈ armor_value\n4 ≈ weapon"
  number_sort = gets.chomp.to_i
  puts 'please type ASC or DESC for order'
  asc_desc = gets.chomp.upcase
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



# def sort_by_armor(conn)
#   result = conn.exec('SELECT * FROM characters ORDER BY armor_value DESC')
#   # can add diff columns instead of the *
#   # Conn is being passed in .... is that a class!!?!?!
#   puts 'Armor Rankings:'
#   result.each do |character|
#     puts "Name: #{character['name']} ≈ #{character['armor_value']}"
#   end
# end
