require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(id:7, username:"admin@ncsu.edu", password: "123456", name:"Admin", email:"admin@ncsu.edu", address:"NC", credit_card_number:1234556789012345, phone_number:"98123456780")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  
end