require_relative '../../db/config'
require 'byebug'

class Representative < Legislator
	belongs_to :states
	belongs_to :parties
end
