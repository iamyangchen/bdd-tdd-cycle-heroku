require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the MoviesHelper. For example:
#
# describe MoviesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe MoviesHelper do
  #pending "add some examples to (or delete) #{__FILE__}"
  before :each do
  	@moviehelper = Class.new {extend MoviesHelper}
  end
  describe 'oddness' do 
  	it 'should ???' do
  	  @moviehelper.oddness 1
  	end
  end
end