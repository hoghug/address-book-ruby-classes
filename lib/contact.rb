class Contact
  attr_reader :first_name, :last_name, :phones, :emails, :addresses

  def Contact.all
    @@all_contacts
  end

  def Contact.clear
    @@all_contacts = []
  end

  def Contact.create name
    new_contact = Contact.new(name)
    new_contact.save
    new_contact
  end

  def initialize name
    if name =~ /\s/
      @first_name = name.split(' ')[0]
      @last_name = name.split(' ')[1]
    else
      @first_name = name
      @last_name = ''
    end
    @phones = []
    @emails = []
    @addresses = []
  end

  def save
    @@all_contacts << self
  end

  def full_name
    @first_name + ' ' + @last_name
  end

  def add_phone phone
    @phones << phone
  end

  def add_email email
    @emails << email
  end

  def add_address address
    @addresses << address
  end
end

class Record
  attr_reader :content

  def initialize content
    @content = content
  end
end

