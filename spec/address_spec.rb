require 'contact'
require 'email'
require 'address'
require 'phone'
require 'rspec'

describe Contact do
  before do
    Contact.clear
  end

  describe '.create' do
    it 'creates a new contact' do
        test_contact = Contact.create('John Smith')
        test_contact.should be_an_instance_of Contact
    end
  end

  describe '#save' do
    it 'will save the contact to the array' do
      test_contact = Contact.create('John Smith')
      Contact.all.should eq [test_contact]
    end
  end

  describe '#add_phone' do
    it 'adds a Phone instance to phones[]' do
      test_contact = Contact.create('John Smith')
      test_phone = Phone.new(5038107237)
      test_contact.add_phone(test_phone)
      test_contact.phones.should eq [test_phone]
    end
  end

  describe '#full_name' do
    it 'returns the full name of the contact' do
      test_contact = Contact.create('John Smith')
      test_contact.full_name.should eq 'John Smith'
    end
  end
end

describe Phone do
  describe '.new' do
    it 'creates a new phone number object' do
      test_phone = Phone.new(5038107237)
      test_phone.should be_an_instance_of Phone
    end
  end

  describe '#format' do
    it 'returns the phone number as a string with proper formatting' do
      test_phone = Phone.new(5038107237)
      test_phone.format.should eq '(503) 810-7237'
    end
  end
end



