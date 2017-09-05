require_relative '../../db/config'
require 'byebug'

class Senator < Legislator
	belongs_to :states
	belongs_to :parties
end
