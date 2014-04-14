require 'spec_helper'

describe UsersController do

  describe "GET 'show'" do
    xit "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "#half_line_counts" do # this is a private method, so this is not the proper way to test this.
    xit "can half the line counts of every language in the hash" do
      language_array = [{:Ruby=>10037}, {:Ruby=>4118, :CSS=>6040}, {:Arduino=>2285, :JavaScript=>1078, :Ruby=>965}, {:Ruby=>5437}, {}, {:JavaScript=>27654}, {:Ruby=>20027, :JavaScript=>664, :CoffeeScript=>211, :CSS=>1749}, {:Ruby=>68329, :JavaScript=>3801, :CoffeeScript=>845, :CSS=>4901}] 
      @controller.half_line_counts(language_array)
      expect(language_array[1][:CSS]).to eq(3020)
    end
  end

end
