require 'json'

class DataReader
  def initialize(file)
    @file = file
  end

  def read
    JSON.parse(File.read("acts_data/products_#{@file}.json"))
  end
end
