require './lib/contact'
require './lib/email'
require './lib/address'
require './lib/phone'

Contact.clear

def main_menu
  if Contact.all.length < 1
    add_contact
  else
    puts 'Choose option from menu:'
    puts "\tn: new contact"
    puts "\td: delete contact"
    puts "\tl: list contacts"
    puts "\t#: choose contact"
    puts "\tz: advanced interface"
    puts "\tx: exit"
    choice = gets.chomp
    if choice == 'n'
      add_contact
    elsif choice == 'd'
      delete_contact
    elsif choice == 'l'
      list_contacts
      main_menu
    elsif choice =~ /^[-+]?[0-9]+$/
      number_choice = choice.to_i
      contact_menu(Contact.all[number_choice-1])
    elsif choice == 'z'
      advanced_menu
    elsif choice == 'x'
        puts "Goodbye!"
    else
      puts 'Invalid option'
      main_menu
    end
  end
end

def advanced_menu
  list_contacts
  puts "contact # | add, delete, list | address, phone, email"
  print "Enter a command: "
  input = gets.chomp.split(' ')
  contact = Contact.all[input[0].to_i - 1]
  action = input[1]
  type = input[2]

  if action == 'add'
    if type == 'address'
      add_address(contact)
    elsif type == 'phone'
      add_phone(contact)
    else
      add_email(contact)
    end
  elsif action == 'delete'
    if type == 'address'
      delete_address(contact)
    elsif type == 'phone'
      delete_phone(contact)
    else
      delete_email(contact)
    end
  elsif action == 'list'
    if type == 'address'
      list_addresses(contact)
    elsif type == 'phone'
      list_phones(contact)
    else
      list_emails(contact)
    end
  else
    puts 'Invalid command'
    advanced_menu
  end


end

def list_contacts
  Contact.all.each_with_index do |contact, index|
    puts "#{index + 1}: #{contact.full_name}"
  end
end

def add_contact
  print 'Enter a name: '
  name = gets.chomp
  new_contact = Contact.create(name)
  puts "#{new_contact.full_name} has been created\n"
  contact_menu(new_contact)
end

def delete_contact
  list_contacts
  print 'Enter a # for the contact to delete: '
  choice = gets.chomp.to_i
  deleted_contact = Contact.all[choice-1]
  name = deleted_contact.full_name
  Contact.all.delete(deleted_contact)
  puts "#{name} deleted."
  main_menu
end

def contact_menu contact
  puts "#{contact.full_name} selected."
  puts 'Choose option from menu:'
  puts "\tp: phone menu"
  puts "\te: email menu"
  puts "\ta: address menu"
  puts "\tz: advanced interface"
  puts "\tx: main menu"
  choice = gets.chomp
  if choice == 'p'
    phone_menu(contact)
  elsif choice == 'e'
    email_menu(contact)
  elsif choice == 'a'
    address_menu(contact)
  elsif choice == 'x'
    main_menu
  elsif choice == 'z'
    advanced_menu
  else
    puts 'Invalid option'
    contact_menu(contact)
  end
end

def phone_menu contact
  puts "Phones for #{contact.full_name} selected."
  puts 'Choose option from menu:'
  puts "\tl: list phone numbers"
  puts "\tn: new phone number"
  puts "\td: delete phone number"
  puts "\tx: contact menu"
  puts "\tz: advanced interface"
  choice = gets.chomp
  if choice == 'l'
    list_phones(contact)
    phone_menu(contact)
  elsif choice == 'n'
    add_phone(contact)
  elsif choice == 'd'
    delete_phone(contact)
  elsif choice == 'x'
    contact_menu(contact)
  elsif choice == 'z'
    advanced_menu
  else
    puts 'Invalid option'
    phone_menu(contact)
  end
end

def list_phones contact
  puts "Phones for #{contact.full_name}:"
  contact.phones.each_with_index do |phone, index|
    puts "\t#{index + 1}: #{phone.format}"
  end
  phone_menu(contact)
end

def add_phone contact
  print 'Enter a number: '
  number = gets.chomp.to_i
  new_phone = Phone.new(number)
  contact.add_phone(new_phone)
  puts "#{new_phone.format} has been added to #{contact.full_name}\n"
  phone_menu(contact)
end

def delete_phone contact
  list_phones(contact)
  print 'Enter a # for the phone number to delete: '
  choice = gets.chomp.to_i
  deleted_phone = contact.phones[choice-1]
  name = deleted_phone.format
  contact.phones.delete(deleted_phone)
  puts "#{name} deleted."
  phone_menu(contact)
end

def email_menu contact
  puts "Emails for #{contact.full_name} selected."
  puts 'Choose option from menu:'
  puts "\tl: list email addresses"
  puts "\tn: new email address"
  puts "\td: delete email address"
  puts "\tx: contact menu"
  choice = gets.chomp
  if choice == 'l'
    list_emails(contact)
    email_menu(contact)
  elsif choice == 'n'
    add_email(contact)
  elsif choice == 'd'
    delete_email(contact)
  elsif choice == 'x'
    contact_menu(contact)
  elsif choice == 'z'
    advanced_menu
  else
    puts 'Invalid option'
    email_menu(contact)
  end
end

def list_emails contact
  puts "Emails for #{contact.full_name}:"
  contact.emails.each_with_index do |email, index|
    puts "\t#{index + 1}: #{email.content}"
  end
end

def add_email contact
  print 'Enter an email address: '
  address = gets.chomp
  new_email = Email.new(address)
  contact.add_email(new_email)
  puts "#{new_email.content} has been added to #{contact.full_name}\n"
  email_menu(contact)
end

def delete_email contact
  list_emails(contact)
  print 'Enter a # for the email address to delete: '
  choice = gets.chomp.to_i
  deleted_email = contact.emails[choice-1]
  name = deleted_email.content
  contact.emails.delete(deleted_email)
  puts "#{name} deleted."
  email_menu(contact)
end

def address_menu contact
  puts "Addresses for #{contact.full_name} selected."
  puts 'Choose option from menu:'
  puts "\tl: list addresses"
  puts "\tn: new address"
  puts "\td: delete address"
  puts "\tx: contact menu"
  choice = gets.chomp
  if choice == 'l'
    list_addresses(contact)
    address_menu(contact)
  elsif choice == 'n'
    add_address(contact)
  elsif choice == 'd'
    delete_address(contact)
  elsif choice == 'x'
    contact_menu(contact)
  elsif choice == 'z'
    advanced_menu
  else
    puts 'Invalid option'
    address_menu(contact)
  end
end

def list_addresses contact
  puts "Addresses for #{contact.full_name}:"
  contact.addresses.each_with_index do |address, index|
    puts "\t#{index + 1}: #{address.format}"
  end
  address_menu(contact)
end

def add_address contact
  print 'Enter an address: '
  address = gets.chomp
  new_address = Address.new(address)
  contact.add_address(new_address)
  puts "#{new_address.content} has been added to #{contact.full_name}\n"
  address_menu(contact)
end

def delete_address contact
  list_addresses(contact)
  print 'Enter a # for the address to delete: '
  choice = gets.chomp.to_i
  deleted_address = contact.addresses[choice-1]
  name = deleted_address.content
  contact.addresses.delete(deleted_address)
  puts "#{name} deleted."
  address_menu(contact)
end

main_menu
