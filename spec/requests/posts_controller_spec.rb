require 'rails_helper'

RSpec.describe PostsController, type: :request do
  context '/users/:user_id/posts route (GET #index)' do
    before(:each) { get '/users/1/posts' }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render index.html.erb file from views/posts (render 'index' template)" do
      expect(response).to render_template('index')
    end

    it "should render the correct content in the 'index' template" do
      expect(response.body).to include('Number of posts')
    end
  end

  context '/users/:user_id/posts/:id route (GET #show)' do
    before(:each) { get '/users/1/posts/1' }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render show.html.erb file from views/posts (render 'show' template)" do
      expect(response).to render_template('show')
    end

    it "should render the correct content in the 'show' template" do
      expect(response.body).to include('Comment 10')
    end
  end
end
