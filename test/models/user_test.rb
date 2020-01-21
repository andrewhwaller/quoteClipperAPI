require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "a user with a valid email should be vaild" do
		user = User.new(email: "username@emailsite.org", password_digest: "password")
		assert user.valid?
	end

	test "a user with an invalid email should not be valid" do
		user = User.new(email: "emailemail", password_digest: "password")
		assert_not user.valid?
	end

	test "a user with a duplicate email should not be valid" do
		dupe_user = users(:one)
		user = User.new(email: dupe_user.email, password_digest: "password")
		assert_not user.valid?
	end
end
