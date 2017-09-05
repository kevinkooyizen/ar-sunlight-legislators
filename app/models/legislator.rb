require_relative '../../db/config'
require 'byebug'

class Legislator < ActiveRecord::Base
	# validates :phone, :format => { :with => /(.*(\d).*){10,}/ }
	# validates :email, :format => { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]{2,}+\z/ }
	# validates :email, :uniqueness => true
	validates :age, :numericality => { :greater_than_or_equal_to => 5}
	before_validation :age



	def age
		now = Time.now.utc.to_date
	  	now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
	end
end