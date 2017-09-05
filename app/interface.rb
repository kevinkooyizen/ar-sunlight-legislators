
require_relative '../db/config'
require 'erb'
require_relative 'models/legislator'
require_relative 'models/representative'
require_relative 'models/senator'
require 'byebug'

def legislator_index
  puts "Please input initials of a state."
  input = gets.chomp.upcase
  senators = []
  representatives = []
  Legislator.where("state = '#{input}'").where.not(congress_office: "").order(:lastname).each do |s|
    if s.title == "Sen"
      senators << [s.firstname, s.middlename, s.lastname, s.party]
    end
    if s.title == "Rep"
      representatives << [s.firstname, s.middlename, s.lastname, s.party]
    end
  end

  puts "Senators:"
  senators.each do |i|
    if i[1] != ""
      print "   " + i[0..2].join(" ") + " (#{i[-1]})" + "\n"
    else
      print "   " + i[0] + " " + i[2] + " (#{i[-1]})" + "\n"
    end
  end

  puts ""
  puts "Representatives:"
  representatives.each do |i|
    if i[1] != ""
      print "   " + i[0..2].join(" ") + " (#{i[-1]})" + "\n"
    else
      print "   " + i[0] + " " + i[2] + " (#{i[-1]})" + "\n"
    end
  end
end

def list_states
  index = 1
  Legislator.distinct.pluck(:state).each do |s|
    puts "#{s}: #{Legislator.where(title: "Sen", state: "#{s}").where.not(congress_office: "").count} Senators, #{Legislator.where(title: "Rep", state: "#{s}").where.not(congress_office: "").count} Representative(s)"
    index += 1
  end
end

def legislator_demographics
  puts "Please select a gender"
  input = gets.chomp.capitalize
  puts "#{input} Senators: #{Legislator.where(title: "Sen", gender: "#{input[0]}").where.not(congress_office: "").count} " + (Legislator.where("gender = '#{input[0]}'").count*100/Legislator.count).to_s + "%"
  puts "#{input} Representatives: #{Legislator.where(title: "Rep", gender: "#{input[0]}").where.not(congress_office: "").count} " + (Legislator.where("gender = '#{input[0]}'").count*100/Legislator.count).to_s + "%"
end

def legislator_count
  puts "Senators: #{Legislator.where(title: "Sen").count}"
  puts "Representative: #{Legislator.where(title: "Rep").count}"
end

def delete_legislators
  Legislator.where(congress_office: "").destroy_all
  puts "Legislators deleted!"
end

def print_menu
  # BONUS: refactor to sync menu options with case statements
  puts <<~STR

    Welcome! Please pick an option
    1. List all legislators based on state
    2. List all states
    3. Demographics of Legislators by gender
    4. List legislator count
    5. Delete inactive legislators
    6. Exit
  STR
end

# BONUS: clear terminal upon pick option

# puts "Welcome to the Senator database. Please enter your email to login"
# loop do
#   print ">> "
#   input = gets.chomp
#   found = false
#   if Teacher.find_by(email: input)
#     break
#   elsif input == "quit" or input == "exit"
#     return exit
#   else
#     puts ""
#     puts "Email invalid. Please try again."
#   end
# end
loop do
  print_menu
  # BONUS: refactor repetitive prompt
  print ">> "
  input = gets.chomp
  case input
  when "1"
    puts "=== Legislator search by state ===\n"
    legislator_index
  when "2"
    puts "=== Listing states ===\n"
    list_states
  when "3"
    puts "=== Demographics of Legislators by gender ===\n"
    legislator_demographics
  when "4"
    puts "=== Listing all legislators ===\n"
    legislator_count
  when "5"
    puts "=== Delete inactive legislators ===\n"
    delete_legislators
  when "6"
    puts "Goodbye!"
    break
  else
    puts "Invalid option!"
  end
end