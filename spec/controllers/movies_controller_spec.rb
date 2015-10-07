require 'spec_helper'

describe MoviesController do
	before :each do
		@fake_movie = double('Movie')
		@fake_movie.stub(:director).and_return('fake_director')
		@fake_movie.stub(:id).and_return('1')
		@fake_movie1 = double('Movie')
		@fake_movie1.stub(:director).and_return('')
		@fake_movie1.stub(:id).and_return('2')
		@fake_movie1.stub(:title).and_return('test_title')
		Movie.stub(:find).with(@fake_movie.id).and_return(@fake_movie)
		Movie.stub(:find).with(@fake_movie1.id).and_return(@fake_movie1)
	end
	describe 'Find similar movies given director' do
    it 'should call the model method that finds similar movies' do
      Movie.should_receive(:find_same_director).with(@fake_movie.id)
      get :find_with_same_director, {:id => @fake_movie.id}
    end
    it 'should select the Find Similar Movies for rendering' do
      Movie.stub(:find_same_director)
      get :find_with_same_director, {:id => @fake_movie.id}
      response.should render_template('find_with_same_director')
    end
    it 'should make the Similar Movies search results available to that template' do
      fake_results = [double('Movie'), double('Movie')]
      Movie.stub(:find_same_director).and_return(fake_results)
      get :find_with_same_director, {:id => @fake_movie.id}
      # look for controller method to assign @movies
      assigns(:movies).should == fake_results
    end
    it 'should return to home page if no director info is available' do
      Movie.stub(:find_same_director).with(@fake_movie1.id)
      get :find_with_same_director, {:id => @fake_movie1.id}
      response.should redirect_to(movies_path)
    end
  end
  describe 'Create movies' do
  	it 'should call the model method that create a movie' do
  	  @newmovie = double('Movie', :title=>'faketitle')
  	  Movie.should_receive(:create!).and_return(@newmovie)
  	  post :create, {:movie => @newmovie}
  	end
  end
  describe 'edit movies' do
  	it 'should call the model method find and return a movie' do
  	  @newmovie = double('Movie', :id => 1)
  	  Movie.should_receive(:find).and_return(@newmovie)
  	  get :edit, {:id => @newmovie.id}
  	end
  end
  describe 'update movies' do 
  	before :each do
	  @newmovie = double('Movie', :title=>'faketitle', :id => '1', :director => 'fake')
  	  Movie.should_receive(:find).and_return(@newmovie)
  	  @newmovie.should_receive(:update_attributes!)
  	  put :update, {:id => @newmovie.id, :movie => @newmovie}
	end
  	it 'should update the movie' do
  	  assigns(:movie).should == @newmovie
  	end
  	it 'should return to the home page' do
  	  response.should redirect_to(movie_path @newmovie)
  	end
  end
  describe 'destroy movies' do 
  	before :each do
	  @newmovie = double('Movie', :title=>'faketitle', :id => '1', :director => 'fake')
  	  Movie.should_receive(:find).and_return(@newmovie)
  	  @newmovie.should_receive(:destroy)
  	  delete :destroy, {:id => @newmovie.id}
	end
  	it 'should return to the home page' do
  	  response.should redirect_to(movies_path)
  	end
  end

  describe 'show the movie' do
  	it 'should call the model method and find the movie' do
  	  @newmovie = double('Movie', :title=>'faketitle', :id => '1', :director => 'fake')
  	  Movie.should_receive(:find).with(@newmovie.id).and_return(@newmovie)
  	  get :show, {:id => @newmovie.id}
  	end
  end
  describe 'show index' do 
  	it 'should render index template' do 
  		get :index
  		response.should render_template('index')
  	end
    it 'should sort based on title if select title' do
      get :index, {:sort => 'title'}
      assigns(:title_header).should == 'hilite'
    end
    it 'should sort based on release_date if select release_date' do
      get :index, {:sort => 'release_date'}
      assigns(:date_header).should == 'hilite'
    end
  end
end
