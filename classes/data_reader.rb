require 'json'

class DataReader
  def initialize(file)
    @file = file
  end

  def read
    JSON.parse(File.read("#{@file}.json"))
  end
end
