RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    user = User.new(first_name: "Parth", last_name: "Patel", email: "hi@gmail.com", password: "1234567", password_confirmation: "1234567")
    user.save
    it "should return user if email and password are correct" do
      result = User.authenticate_with_credentials("hi@gmail.com", "1234567")
      expect(result).to be_instance_of(User)
    end

    it "should return nil if email does not exist" do
      result = User.authenticate_with_credentials("hiooo@gmail.com", "1234567")
      expect(result).to be_nil
    end

    it "should return false if passwords dont match" do
      result = User.authenticate_with_credentials("hi@gmail.com", "12344567")
      expect(result).to be false
    end
  end

end