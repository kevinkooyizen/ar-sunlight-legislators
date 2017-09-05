require 'csv'
require 'byebug'

class StatesImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      attribute_hash = {}
      row.each do |field, value|
        if field == "state"
          attribute_hash[field] = value
        end
      end
      # attribute_hash["birthdate"] = Date.strptime(attribute_hash["birthdate"], '%m/%d/%Y')
      byebug
      state = State.create!(name: attribute_hash["state"])
      byebug
    end
  end
end