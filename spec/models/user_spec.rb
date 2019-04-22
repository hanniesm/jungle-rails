require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let (:name) {'Tiffany Weatherbottom'}
    let (:email) {'whether@email.com'}
    let (:password) {'Password'}
    let (:password_confirmation) {'Password'}
    let (:user) {User.new name: name, email: email, password: password, password_confirmation: password_confirmation}

    it 'is valid with the proper attributes' do
      expect(user).to be_valid
    end
    
    it 'is not valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'password length less than 5 characters is invalid' do
      user.password = '1234'
      result = user.save
  
      expect(result).to be(false)
    end

    it 'password length must be at least 5 characters' do
      result = user.save
  
      expect(result).to be(true)
    end

    it 'email must be unique' do
      user.save
      user2 = User.new(name: 'Frank Hammond', email: 'whether@email.com', password: 'password', password_confirmation: 'password')  
      user2.save
      expect(user2.errors.get(:email)).to eq(["has already been taken"])
    end 
    
    it 'email must be unique' do
      user.save
      user3 = User.new(name: 'Frank Hammond', email: 'WHETHER@email.com', password: 'password', password_confirmation: 'password')  
      user3.save
      expect(user3.errors.get(:email)).to eq(["has already been taken"])
    end 

    it 'email may have blank spaces' do
      user.email = '  whether@email.com'
      user.save
      expect(user).to be_valid
    end 
    
  end

  describe '.authenticate_with_credentials' do

    it 'is authenticated with proper credentials' do
      userTest = User.authenticate_with_credentials('something@email.com', 'password')
      expect(userTest.name).to eql("John Johnnyson")
    end

    it 'is not authenticated without correct email' do
      userTest = User.authenticate_with_credentials('some@email.com', 'password')
      expect(userTest).to eql(false)
    end

    it 'is not authenticated without correct password' do
      userTest = User.authenticate_with_credentials('something@email.com', 'pasword')
      expect(userTest).to eql(false)
    end

    it 'is authenticated with email in wrong case' do
      user10 = User.new(name: 'Frank Hammond', email: 'some@email.com', password: 'password', password_confirmation: 'password')  
      user10.save
      userTest = User.authenticate_with_credentials('SOME@email.com', 'password')
      expect(userTest.name).to eql("Frank Hammond")
    end

  end

end

 
