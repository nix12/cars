require 'rubygems'
require 'sqlite3'

$db = SQLite3::Database.new('carsfile')
$db.results_as_hash = true

def create_table
	$db.execute(
		"CREATE TABLE IF NOT EXISTS cars (
			id integer primary key,
			firstName varchar(50),
			lastName varchar(50),
			license varchar(50),
			make varchar(10),
			model varchar(10))"
		)
end

def disconnect_and_quit
	$db.close
	puts "Good Bye!"
	exit
end

def add_record
		puts "Enter first name: "
		firstName = gets.chomp

		puts "Enter last name: "
		lastName = gets.chomp

		puts "Enter license: "
		license = gets.chomp

		puts "Enter Make: "
		make = gets.chomp

		puts "Enter Model: "
		model = gets.chomp

	$db.execute(
		"INSERT INTO cars (firstName, lastName, license, make, model)
		VALUES (?, ?, ?, ?, ?)",
		firstName, lastName, license, make, model)

	puts "New record added."
end

def delete_record
	puts "Please enter record you wish to delete by id, first name, or last name."
	record = gets.chomp

	$db.execute(
		"DELETE FROM cars
		WHERE firstName = ? OR lastName = ? OR id = ?",
		record, record, record.to_i
		)

	puts "Record has be DELETED."
end

def update_record
	puts "What record would you like to update"
	id = gets.chomp
	puts "Change license plate"
	record = gets.chomp

	$db.execute(
		"UPDATE cars
		SET license = ?
		WHERE id = ?", record, id
		)
	puts "Record has been updated."
end

def find_record
	puts "Search for record by ID or License."
	record = gets.chomp

	res = $db.execute(
		"SELECT * FROM cars
		WHERE id = ? OR license = ?", record.to_i, record
		).first
	
	unless res
		puts "Result no found"
		return
	end

	puts %Q{
		First Name: #{res['firstName']}
		Last Name: #{res['lastName']}
		License: #{res['license']}
		Make: #{res['make']}
		Model: #{res['model']}
	}
end

def print_records
	res = $db.execute("SELECT * FROM cars")

	res.each do |x|
		puts x
	end
end 