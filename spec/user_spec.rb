require "rails_helper"

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      first_name:            "Test",
      last_name:             "User",
      email:                 "test@test.com",
      password:              "secret",
      password_confirmation: "secret"
    )
  end

  describe 'Validations' do
    # validation tests/examples here
    it 'Should create an user with valid fileds for testing' do
      expect(subject).to be_valid
    end
    it "invalid with missing first name" do
      subject.first_name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end
    it "invalid with missing last name" do
      subject.last_name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end
    it "invalid with missing email" do
      subject.email = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end
    it "invalid with missing password" do
      subject.password = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end
    it "invalid with missing password confirmation" do
      subject.password_confirmation = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "invalid with password confirmation doesn't match password" do
      subject.password = 'password'
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "invalid with short password length" do
      subject.password = "1"
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.any? {|error| error.include?("Password is too short")}).to be(true)
    end
    
    it "invalid with existing email" do
      user = User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "secret",
        password_confirmation: "secret"
      )
      user.save
      subject.save
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end
    it "invalid with existing case insensitive email" do
      user = User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "TEST@TEST.com",
        password:              "secret",
        password_confirmation: "secret"
      )
      user.save
      subject.save
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "return nil with nil email and password" do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end
    it "return nil with invalid email" do
      expect(User.authenticate_with_credentials("nope@nope.nope", "12345678")).to eq(nil)
    end
    it "return nil with nil password" do
      expect(User.authenticate_with_credentials("test@test.com", nil)).to eq(nil)
    end
    it "return a user with valid email and password" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "secret",
        password_confirmation: "secret"
      ).save
      user = User.authenticate_with_credentials("test@test.com", "secret")
      expect(user.email).to eq("test@test.com")
    end
    it "return a user with valid email and password case insensitive" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "secret",
        password_confirmation: "secret"
      ).save
      user = User.authenticate_with_credentials("TEST@TEST.COM", "secret")
      expect(user.email).to eq("test@test.com")
    end
    it "return a user with valid email and password case insensitive with leading spaces" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "secret",
        password_confirmation: "secret"
      ).save
      user = User.authenticate_with_credentials("   TEST@TEST.COM", "secret")
      expect(user.email).to eq("test@test.com")
    end
    it "return a user with valid email and password case insensitive with trailing spaces" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "secret",
        password_confirmation: "secret"
      ).save
      user = User.authenticate_with_credentials("TEST@TEST.COM   ", "secret")
      expect(user.email).to eq("test@test.com")
    end
    it "return a user with valid email and password case insensitive with leading and trailing spaces" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "secret",
        password_confirmation: "secret"
      ).save
      user = User.authenticate_with_credentials("   TEST@TEST.cOM   ", "secret")
      expect(user.email).to eq("test@test.com")
    end
  end

end