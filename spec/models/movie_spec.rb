require 'spec_helper'

describe Movie do
  #pending "add some examples to (or delete) #{__FILE__}"
  before :each do
	  	@fake_movie = double('Movie')
		@fake_movie.stub(:director).and_return('fake_director')
		@fake_movie.stub(:id).and_return('1')
		Movie.stub(:find).with(@fake_movie.id).and_return(@fake_movie)
  end
  describe 'find same director' do 
  	it 'should all model method' do 
  		Movie.find_same_director '1'
  	end
  end
end
