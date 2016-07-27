require './cars.rb'

loop do
	create_table

	puts %Q{ Please pick an option

	1. Add new record
	2. Update record
	3. Delete record
	4. Search for record
	5. Print records
	6. Quit}

	case gets.chomp
		when '1'
			add_record
		when '2'
			update_record
		when '3'
			delete_record
		when '4'
			find_record
		when '5'
			print_records
		when '6'
			disconnect_and_quit
	end	
end